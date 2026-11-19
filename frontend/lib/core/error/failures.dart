import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Unable to reach the ERP server. Check your network connection.']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'You are not authorized to perform this action.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
