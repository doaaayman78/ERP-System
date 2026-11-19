import '../models/procurement_models.dart';
import 'procurement_repository.dart';

class MockProcurementRepository implements ProcurementRepository {
  @override
  Future<List<SupplierModel>> getSuppliers() async => const [
        SupplierModel(code: 'SUP-001', name: 'Nile Medical Co.', contact: '0100 123 4567', creditLimit: 50000, balance: 18500, status: 'Active'),
        SupplierModel(code: 'SUP-002', name: 'Care Supplies Ltd.', contact: '0101 234 5678', creditLimit: 30000, balance: 8200, status: 'Active'),
        SupplierModel(code: 'SUP-003', name: 'Health Plus Trading', contact: '0102 345 6789', creditLimit: 20000, balance: 0, status: 'Active'),
      ];

  @override
  Future<List<PurchaseInvoiceModel>> getPurchases() async => const [
        PurchaseInvoiceModel(invoiceNumber: 'PUR-2026-401', supplierName: 'Nile Medical Co.', date: '16 Nov 2026', total: 18500, bonusUnits: 12, status: 'Confirmed'),
        PurchaseInvoiceModel(invoiceNumber: 'PUR-2026-400', supplierName: 'Care Supplies Ltd.', date: '14 Nov 2026', total: 8200, bonusUnits: 5, status: 'Draft'),
      ];
}
