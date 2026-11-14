-- All examples are templates: execute the whole business operation in one transaction.
-- Customer / supplier
INSERT INTO party.business_entities(entity_code,entity_type,legal_name,display_name,name,email) VALUES ('CUST-001','ORGANIZATION','Acme Customer','Acme Customer','Acme Customer','ar@acme.example') RETURNING entity_id;
INSERT INTO party.entity_roles(entity_id,role_code) VALUES (:entity_id,'CUSTOMER');
INSERT INTO party.customer_profiles(entity_id,credit_limit,payment_terms_days) VALUES (:entity_id,10000,30);
INSERT INTO party.business_entities(entity_code,entity_type,legal_name,display_name,name,email) VALUES ('SUP-001','ORGANIZATION','Global Supplier','Global Supplier','Global Supplier','ap@global.example') RETURNING entity_id;
INSERT INTO party.entity_roles(entity_id,role_code) VALUES (:entity_id,'SUPPLIER');
INSERT INTO party.supplier_profiles(entity_id,credit_limit,payment_terms_days) VALUES (:entity_id,50000,45);

-- Product and a price history row (never update an old price)
INSERT INTO catalog.products(product_code,barcode,name,category_id,brand_id) VALUES ('SKU-001','0123456789012','Example Product',:category_id,:brand_id) RETURNING product_id;
INSERT INTO catalog.product_units(product_id,unit_id,conversion_factor,is_default_sales_unit,is_default_purchase_unit) VALUES (:product_id,:unit_id,1,true,true);
INSERT INTO pricing.product_prices(price_list_id,product_id,product_unit_id,price,effective_from) VALUES (:price_list_id,:product_id,:product_unit_id,25.0000,now());

-- Receive stock: receipt confirmation, balance lock/update, movement and outbox are one transaction.
BEGIN;
SELECT stock_balance_id FROM inventory.stock_balances WHERE product_id=:product_id AND unit_id=:unit_id AND warehouse_id=:warehouse_id AND location_id=:location_id AND batch_id IS NOT DISTINCT FROM :batch_id FOR UPDATE;
UPDATE inventory.stock_balances SET quantity_on_hand=quantity_on_hand+:qty,version=version+1,updated_at=now() WHERE stock_balance_id=:stock_balance_id;
INSERT INTO inventory.stock_movements(product_id,unit_id,warehouse_id,location_id,batch_id,movement_type,quantity_delta,reference_type,reference_id,performed_by) VALUES(:product_id,:unit_id,:warehouse_id,:location_id,:batch_id,'PURCHASE_RECEIPT',:qty,'WAREHOUSE_RECEIPT',:receipt_id,:user_id);
INSERT INTO integration.outbox_events(aggregate_type,aggregate_id,event_type,payload) VALUES('WAREHOUSE_RECEIPT',:receipt_id,'WarehouseReceiptConfirmed',jsonb_build_object('receipt_id',:receipt_id)); COMMIT;

-- Safe sale: lock, verify, decrement, movement, invoice event.
BEGIN;
SELECT stock_balance_id,quantity_on_hand,quantity_reserved FROM inventory.stock_balances WHERE stock_balance_id=:stock_balance_id FOR UPDATE;
-- Application aborts if quantity_on_hand-quantity_reserved < :qty.
UPDATE inventory.stock_balances SET quantity_on_hand=quantity_on_hand-:qty,version=version+1,updated_at=now() WHERE stock_balance_id=:stock_balance_id AND quantity_on_hand-quantity_reserved>=:qty;
INSERT INTO inventory.stock_movements(product_id,unit_id,warehouse_id,location_id,batch_id,movement_type,quantity_delta,reference_type,reference_id,performed_by) VALUES(:product_id,:unit_id,:warehouse_id,:location_id,:batch_id,'SALE',-:qty,'SALES_INVOICE',:invoice_id,:user_id);
INSERT INTO integration.outbox_events(aggregate_type,aggregate_id,event_type,payload) VALUES('SALES_INVOICE',:invoice_id,'SalesInvoiceConfirmed',jsonb_build_object('invoice_id',:invoice_id)); COMMIT;

-- Reservation / release (lock every affected balance in stable stock_balance_id order)
BEGIN;
SELECT stock_balance_id,quantity_on_hand,quantity_reserved FROM inventory.stock_balances WHERE stock_balance_id=:stock_balance_id FOR UPDATE;
UPDATE inventory.stock_balances SET quantity_reserved=quantity_reserved+:qty,version=version+1 WHERE stock_balance_id=:stock_balance_id AND quantity_on_hand-quantity_reserved>=:qty;
INSERT INTO inventory.stock_movements(product_id,unit_id,warehouse_id,location_id,batch_id,movement_type,quantity_delta,reference_type,reference_id,performed_by) VALUES(:product_id,:unit_id,:warehouse_id,:location_id,:batch_id,'RESERVATION',:qty,'RESERVATION',:reservation_id,:user_id);
-- Release uses the same lock and quantity_reserved=quantity_reserved-:qty, then movement type RELEASE_RESERVATION.
COMMIT;

-- Payment and allocation: lock payment and all target documents, validate remaining amount, then insert both rows.
BEGIN;
SELECT amount FROM finance.payments WHERE payment_id=:payment_id FOR UPDATE;
SELECT COALESCE(sum(amount),0) FROM finance.payment_allocations WHERE payment_id=:payment_id FOR UPDATE;
INSERT INTO finance.payment_allocations(payment_id,document_type,document_id,amount) VALUES(:payment_id,'SALES_INVOICE',:invoice_id,:amount);
INSERT INTO finance.cash_transactions(cash_account_id,transaction_type,amount,direction,reference_type,reference_id,created_by) VALUES(:cash_account_id,'CUSTOMER_PAYMENT',:amount,'C','PAYMENT',:payment_id,:user_id); COMMIT;

-- Returns/refunds: confirm return and create a separate refund only when approved.
INSERT INTO returns.returns(return_number,return_type,source_type,source_id,entity_id,created_by) VALUES(:return_number,'CUSTOMER','SALES_INVOICE',:invoice_id,:customer_id,:user_id) RETURNING return_id;
INSERT INTO returns.refunds(return_id,refund_type,amount) VALUES(:return_id,'CASH',:amount);

-- Common reporting
SELECT * FROM inventory.v_low_stock ORDER BY product_code;
SELECT * FROM inventory.v_current_stock WHERE product_id=:product_id;
SELECT * FROM sales.v_invoice_outstanding WHERE customer_id=:customer_id;
SELECT * FROM finance.v_customer_statement WHERE entity_id=:customer_id ORDER BY statement_date;
SELECT * FROM finance.v_supplier_statement WHERE entity_id=:supplier_id ORDER BY statement_date;
UPDATE sales.sales_invoices SET status='CANCELLED',version=version+1,updated_at=now() WHERE sales_invoice_id=:invoice_id AND status='DRAFT';
INSERT INTO audit.audit_logs(user_id,action,entity_type,entity_id,old_values,new_values,reason,correlation_id) VALUES(:user_id,'STATUS_CHANGE','sales.sales_invoices',:invoice_id,:old_json,:new_json,:reason,:correlation_id);
INSERT INTO integration.outbox_events(aggregate_type,aggregate_id,event_type,payload) VALUES('SALES_INVOICE',:invoice_id,'SalesInvoiceCancelled',:payload);
