import '../models/stock_item_model.dart';
import 'inventory_repository.dart';

class MockInventoryRepository implements InventoryRepository {
  @override
  Future<List<StockItemModel>> getStock() async => const [
        StockItemModel(productName: 'Vitamin C 1000mg', warehouse: 'Main warehouse', onHand: 8, reserved: 0, minLevel: 15),
        StockItemModel(productName: 'Baby Care Lotion', warehouse: 'Store A', onHand: 120, reserved: 10, minLevel: 20, expiryWarning: 'Expires in 14 days'),
        StockItemModel(productName: 'Pain Relief Gel', warehouse: 'Main warehouse', onHand: 0, reserved: 0, minLevel: 10),
        StockItemModel(productName: 'Medical Gloves', warehouse: 'Store B', onHand: 340, reserved: 20, minLevel: 50),
      ];

  @override
  Future<List<StockMovementModel>> getMovements() async => const [
        StockMovementModel(reference: 'MOV-1048', productName: 'Medical Gloves', movementType: 'Received', delta: 120),
        StockMovementModel(reference: 'MOV-1047', productName: 'Vitamin C 1000mg', movementType: 'Adjusted', delta: -12),
        StockMovementModel(reference: 'MOV-1046', productName: 'Pain Relief Gel', movementType: 'Transferred', delta: 30),
      ];
}
