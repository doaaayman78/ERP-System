import '../models/procurement_models.dart';

abstract class ProcurementRepository {
  Future<List<SupplierModel>> getSuppliers();
  Future<List<PurchaseInvoiceModel>> getPurchases();
}
