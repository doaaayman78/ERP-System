import '../../../../core/network/api_client.dart';
import '../models/stock_item_model.dart';
import 'inventory_repository.dart';

/// TODO [BACKEND API / INVENTORY]: Replace with Inventory microservice endpoints.
class RemoteInventoryRepository implements InventoryRepository {
  final ApiClient _apiClient;

  RemoteInventoryRepository(this._apiClient);

  @override
  Future<List<StockItemModel>> getStock() async {
    // Example: final res = await _apiClient.dio.get('/inventory/stock');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /inventory/stock');
  }

  @override
  Future<List<StockMovementModel>> getMovements() async {
    // Example: final res = await _apiClient.dio.get('/inventory/movements');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /inventory/movements');
  }
}
