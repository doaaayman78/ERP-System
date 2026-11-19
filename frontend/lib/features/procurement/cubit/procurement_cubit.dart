import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/procurement_models.dart';
import '../data/repositories/procurement_repository.dart';

class ProcurementState extends Equatable {
  final List<SupplierModel> suppliers;
  final List<PurchaseInvoiceModel> purchases;
  final String searchQuery;

  const ProcurementState({this.suppliers = const [], this.purchases = const [], this.searchQuery = ''});

  List<SupplierModel> get filteredSuppliers => suppliers
      .where((s) => searchQuery.isEmpty || s.name.toLowerCase().contains(searchQuery.toLowerCase()) || s.code.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  List<PurchaseInvoiceModel> get filteredPurchases => purchases
      .where((p) => searchQuery.isEmpty || p.invoiceNumber.toLowerCase().contains(searchQuery.toLowerCase()) || p.supplierName.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  ProcurementState copyWith({List<SupplierModel>? suppliers, List<PurchaseInvoiceModel>? purchases, String? searchQuery}) {
    return ProcurementState(
      suppliers: suppliers ?? this.suppliers,
      purchases: purchases ?? this.purchases,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [suppliers, purchases, searchQuery];
}

class ProcurementCubit extends Cubit<ProcurementState> {
  final ProcurementRepository _repository;

  ProcurementCubit(this._repository) : super(const ProcurementState()) {
    load();
  }

  Future<void> load() async {
    final suppliers = await _repository.getSuppliers();
    final purchases = await _repository.getPurchases();
    emit(state.copyWith(suppliers: suppliers, purchases: purchases));
  }

  void setSearch(String q) => emit(state.copyWith(searchQuery: q));
}
