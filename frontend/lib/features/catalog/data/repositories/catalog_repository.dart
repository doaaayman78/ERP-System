import '../models/product_model.dart';

abstract class CatalogRepository {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> addProduct(ProductModel product);
}
