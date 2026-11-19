import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/sales_models.dart';
import '../data/repositories/sales_repository.dart';

class SalesState extends Equatable {
  final List<CustomerModel> customers;
  final List<SalesInvoiceModel> invoices;
  final String searchQuery;

  const SalesState({this.customers = const [], this.invoices = const [], this.searchQuery = ''});

  List<SalesInvoiceModel> get filteredInvoices => invoices
      .where((i) => searchQuery.isEmpty || i.invoiceNumber.toLowerCase().contains(searchQuery.toLowerCase()) || i.customerName.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  List<CustomerModel> get filteredCustomers => customers
      .where((c) => searchQuery.isEmpty || c.name.toLowerCase().contains(searchQuery.toLowerCase()) || c.id.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  SalesState copyWith({List<CustomerModel>? customers, List<SalesInvoiceModel>? invoices, String? searchQuery}) {
    return SalesState(
      customers: customers ?? this.customers,
      invoices: invoices ?? this.invoices,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [customers, invoices, searchQuery];
}

class SalesCubit extends Cubit<SalesState> {
  final SalesRepository _repository;

  SalesCubit(this._repository) : super(const SalesState()) {
    load();
  }

  Future<void> load() async {
    final customers = await _repository.getCustomers();
    final invoices = await _repository.getInvoices();
    emit(state.copyWith(customers: customers, invoices: invoices));
  }

  void setSearch(String q) => emit(state.copyWith(searchQuery: q));
}
