import '../models/stock_item_model.dart';

abstract class InventoryRepository {
  Future<List<StockItemModel>> getStock();
  Future<List<StockMovementModel>> getMovements();
}
