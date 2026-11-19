import '../models/product_model.dart';
import 'catalog_repository.dart';

class MockCatalogRepository implements CatalogRepository {
  final List<ProductModel> _products = [
    const ProductModel(id: '1', sku: 'PRD-001', barcode: '6221001', name: 'Vitamin C 1000mg', category: 'Supplements', brand: 'HealthPlus', unit: 'Box', wholesalePrice: 95, retailPrice: 120, status: 'Active'),
    const ProductModel(id: '2', sku: 'PRD-002', barcode: '6221002', name: 'Baby Care Lotion', category: 'Personal care', brand: 'SoftCare', unit: 'Bottle', wholesalePrice: 68, retailPrice: 85, status: 'Active'),
    const ProductModel(id: '3', sku: 'PRD-003', barcode: '6221003', name: 'Pain Relief Gel', category: 'Medicines', brand: 'PharmaCo', unit: 'Tube', wholesalePrice: 50, retailPrice: 65, status: 'Active'),
    const ProductModel(id: '4', sku: 'PRD-004', barcode: '6221004', name: 'Medical Gloves', category: 'Medical supplies', brand: 'SafeMed', unit: 'Pack', wholesalePrice: 75, retailPrice: 95, status: 'Active'),
    const ProductModel(id: '5', sku: 'PRD-005', barcode: '6221005', name: 'Digital Thermometer', category: 'Devices', brand: 'MedTech', unit: 'Piece', wholesalePrice: 140, retailPrice: 180, status: 'Inactive'),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 120));
    return List.unmodifiable(_products);
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    _products.insert(0, product);
    return product;
  }
}
