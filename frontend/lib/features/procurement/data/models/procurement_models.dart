import 'package:equatable/equatable.dart';

class SupplierModel extends Equatable {
  final String code;
  final String name;
  final String contact;
  final double creditLimit;
  final double balance;
  final String status;

  const SupplierModel({
    required this.code,
    required this.name,
    required this.contact,
    required this.creditLimit,
    required this.balance,
    required this.status,
  });

  @override
  List<Object?> get props => [code, name, contact, creditLimit, balance, status];
}

class PurchaseInvoiceModel extends Equatable {
  final String invoiceNumber;
  final String supplierName;
  final String date;
  final double total;
  final int bonusUnits;
  final String status;

  const PurchaseInvoiceModel({
    required this.invoiceNumber,
    required this.supplierName,
    required this.date,
    required this.total,
    required this.bonusUnits,
    required this.status,
  });

  @override
  List<Object?> get props => [invoiceNumber, supplierName, date, total, bonusUnits, status];
}
