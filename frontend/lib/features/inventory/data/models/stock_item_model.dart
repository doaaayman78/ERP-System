import 'package:equatable/equatable.dart';

class StockItemModel extends Equatable {
  final String productName;
  final String warehouse;
  final int onHand;
  final int reserved;
  final int minLevel;
  final String? expiryWarning;

  const StockItemModel({
    required this.productName,
    required this.warehouse,
    required this.onHand,
    required this.reserved,
    required this.minLevel,
    this.expiryWarning,
  });

  int get available => onHand - reserved;
  String get status {
    if (available <= 0) return 'Out of stock';
    if (available <= minLevel) return 'Low stock';
    return 'Healthy';
  }

  @override
  List<Object?> get props => [productName, warehouse, onHand, reserved, minLevel, expiryWarning];
}

class StockMovementModel extends Equatable {
  final String reference;
  final String productName;
  final String movementType;
  final int delta;

  const StockMovementModel({
    required this.reference,
    required this.productName,
    required this.movementType,
    required this.delta,
  });

  @override
  List<Object?> get props => [reference, productName, movementType, delta];
}
