import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';
import 'catalog_repository.dart';

/// TODO [BACKEND API / CATALOG]: Replace with real Catalog microservice calls via ApiClient.
class RemoteCatalogRepository implements CatalogRepository {
  final ApiClient _apiClient;

  RemoteCatalogRepository(this._apiClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    // Example: final res = await _apiClient.dio.get('/catalog/products');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /catalog/products');
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    // Example: final res = await _apiClient.dio.post('/catalog/products', data: {...});
    throw UnimplementedError('TODO [BACKEND API]: Connect POST /catalog/products');
  }
}
