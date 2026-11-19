import '../models/sales_models.dart';

abstract class SalesRepository {
  Future<List<CustomerModel>> getCustomers();
  Future<List<SalesInvoiceModel>> getInvoices();
}
