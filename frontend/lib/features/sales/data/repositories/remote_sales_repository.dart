import '../../../../core/network/api_client.dart';
import '../models/sales_models.dart';
import 'sales_repository.dart';

/// TODO [BACKEND API / SALES]: Connect to Sales & Party microservice endpoints.
class RemoteSalesRepository implements SalesRepository {
  final ApiClient _apiClient;

  RemoteSalesRepository(this._apiClient);

  @override
  Future<List<CustomerModel>> getCustomers() async {
    // Example: final res = await _apiClient.dio.get('/sales/customers');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /sales/customers');
  }

  @override
  Future<List<SalesInvoiceModel>> getInvoices() async {
    // Example: final res = await _apiClient.dio.get('/sales/invoices');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /sales/invoices');
  }
}
