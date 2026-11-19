import '../models/sales_models.dart';
import 'sales_repository.dart';

class MockSalesRepository implements SalesRepository {
  @override
  Future<List<CustomerModel>> getCustomers() async => const [
        CustomerModel(id: 'CUST-001', name: 'Ahmed Hassan', phone: '0100 123 4567', type: 'Retail', creditLimit: 5000, balance: 0, status: 'Active'),
        CustomerModel(id: 'CUST-002', name: 'Nile Medical Co.', phone: '0101 234 5678', type: 'Wholesale', creditLimit: 25000, balance: 12800, status: 'Active'),
        CustomerModel(id: 'CUST-003', name: 'Mona Adel', phone: '0102 345 6789', type: 'Retail', creditLimit: 3000, balance: 1350, status: 'Active'),
      ];

  @override
  Future<List<SalesInvoiceModel>> getInvoices() async => const [
        SalesInvoiceModel(invoiceNumber: 'INV-2026-1048', customerName: 'Ahmed Hassan', date: '16 Nov 2026', total: 4250, paymentStatus: 'Paid', status: 'Confirmed'),
        SalesInvoiceModel(invoiceNumber: 'INV-2026-1047', customerName: 'Nile Medical Co.', date: '16 Nov 2026', total: 12800, paymentStatus: 'Partial', status: 'Confirmed'),
        SalesInvoiceModel(invoiceNumber: 'INV-2026-1046', customerName: 'Mona Adel', date: '15 Nov 2026', total: 1350, paymentStatus: 'Unpaid', status: 'Draft'),
      ];
}
