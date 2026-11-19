import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/stock_item_model.dart';
import '../data/repositories/inventory_repository.dart';

class InventoryState extends Equatable {
  final List<StockItemModel> stock;
  final List<StockMovementModel> movements;
  final String searchQuery;
  final String warehouseFilter;

  const InventoryState({
    this.stock = const [],
    this.movements = const [],
    this.searchQuery = '',
    this.warehouseFilter = 'All',
  });

  List<StockItemModel> get filteredStock => stock.where((s) {
        final q = searchQuery.toLowerCase();
        final matchQ = q.isEmpty || s.productName.toLowerCase().contains(q) || s.warehouse.toLowerCase().contains(q);
        final matchW = warehouseFilter == 'All' || s.warehouse == warehouseFilter;
        return matchQ && matchW;
      }).toList();

  InventoryState copyWith({List<StockItemModel>? stock, List<StockMovementModel>? movements, String? searchQuery, String? warehouseFilter}) {
    return InventoryState(
      stock: stock ?? this.stock,
      movements: movements ?? this.movements,
      searchQuery: searchQuery ?? this.searchQuery,
      warehouseFilter: warehouseFilter ?? this.warehouseFilter,
    );
  }

  @override
  List<Object?> get props => [stock, movements, searchQuery, warehouseFilter];
}

class InventoryCubit extends Cubit<InventoryState> {
  final InventoryRepository _repository;

  InventoryCubit(this._repository) : super(const InventoryState()) {
    load();
  }

  Future<void> load() async {
    final stock = await _repository.getStock();
    final movements = await _repository.getMovements();
    emit(state.copyWith(stock: stock, movements: movements));
  }

  void setSearch(String q) => emit(state.copyWith(searchQuery: q));
  void setWarehouse(String? w) => emit(state.copyWith(warehouseFilter: w ?? 'All'));
}
