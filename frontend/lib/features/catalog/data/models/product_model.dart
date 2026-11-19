import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String sku;
  final String barcode;
  final String name;
  final String category;
  final String brand;
  final String unit;
  final double wholesalePrice;
  final double retailPrice;
  final String status;

  const ProductModel({
    required this.id,
    required this.sku,
    required this.barcode,
    required this.name,
    required this.category,
    required this.brand,
    required this.unit,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.status,
  });

  // TODO [BACKEND API / CATALOG]: Map JSON fields from your Catalog microservice DTO
  @override
  List<Object?> get props => [id, sku, barcode, name, category, brand, unit, wholesalePrice, retailPrice, status];
}
