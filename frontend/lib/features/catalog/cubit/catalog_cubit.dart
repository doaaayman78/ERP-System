import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/product_model.dart';
import '../data/repositories/catalog_repository.dart';

class CatalogState extends Equatable {
  final List<ProductModel> products;
  final String searchQuery;
  final String categoryFilter;
  final bool isLoading;

  const CatalogState({
    this.products = const [],
    this.searchQuery = '',
    this.categoryFilter = 'All',
    this.isLoading = false,
  });

  List<ProductModel> get filteredProducts {
    return products.where((p) {
      final q = searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty || p.name.toLowerCase().contains(q) || p.sku.toLowerCase().contains(q) || p.barcode.contains(q);
      final matchesCat = categoryFilter == 'All' || p.category == categoryFilter;
      return matchesSearch && matchesCat;
    }).toList();
  }

  CatalogState copyWith({List<ProductModel>? products, String? searchQuery, String? categoryFilter, bool? isLoading}) {
    return CatalogState(
      products: products ?? this.products,
      searchQuery: searchQuery ?? this.searchQuery,
      categoryFilter: categoryFilter ?? this.categoryFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [products, searchQuery, categoryFilter, isLoading];
}

class CatalogCubit extends Cubit<CatalogState> {
  final CatalogRepository _repository;

  CatalogCubit(this._repository) : super(const CatalogState()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    emit(state.copyWith(isLoading: true));
    final items = await _repository.getProducts();
    emit(state.copyWith(products: items, isLoading: false));
  }

  void setSearch(String q) => emit(state.copyWith(searchQuery: q));
  void setCategory(String? cat) => emit(state.copyWith(categoryFilter: cat ?? 'All'));

  Future<void> addProduct({
    required String name,
    required String category,
    required String brand,
    required String unit,
    required String barcode,
    required double retailPrice,
  }) async {
    final nextNum = state.products.length + 1;
    final product = ProductModel(
      id: '$nextNum',
      sku: 'PRD-${nextNum.toString().padLeft(3, '0')}',
      barcode: barcode.isEmpty ? '62210${nextNum.toString().padLeft(2, '0')}' : barcode,
      name: name,
      category: category,
      brand: brand,
      unit: unit,
      wholesalePrice: retailPrice * 0.8,
      retailPrice: retailPrice,
      status: 'Active',
    );
    await _repository.addProduct(product);
    await loadProducts();
  }
}
