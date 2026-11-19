import '../../../../core/network/api_client.dart';
import '../models/procurement_models.dart';
import 'procurement_repository.dart';

/// TODO [BACKEND API / PROCUREMENT]: Connect to Purchasing & Supplier microservice endpoints.
class RemoteProcurementRepository implements ProcurementRepository {
  final ApiClient _apiClient;

  RemoteProcurementRepository(this._apiClient);

  @override
  Future<List<SupplierModel>> getSuppliers() async {
    // Example: final res = await _apiClient.dio.get('/procurement/suppliers');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /procurement/suppliers');
  }

  @override
  Future<List<PurchaseInvoiceModel>> getPurchases() async {
    // Example: final res = await _apiClient.dio.get('/procurement/invoices');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /procurement/invoices');
  }
}
