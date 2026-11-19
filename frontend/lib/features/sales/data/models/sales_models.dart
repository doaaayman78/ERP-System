import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String type;
  final double creditLimit;
  final double balance;
  final String status;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.type,
    required this.creditLimit,
    required this.balance,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, phone, type, creditLimit, balance, status];
}

class SalesInvoiceModel extends Equatable {
  final String invoiceNumber;
  final String customerName;
  final String date;
  final double total;
  final String paymentStatus;
  final String status;

  const SalesInvoiceModel({
    required this.invoiceNumber,
    required this.customerName,
    required this.date,
    required this.total,
    required this.paymentStatus,
    required this.status,
  });

  @override
  List<Object?> get props => [invoiceNumber, customerName, date, total, paymentStatus, status];
}
