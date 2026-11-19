import 'package:equatable/equatable.dart';
import '../../../../core/config/navigation_config.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String lastActive;
  final String status;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.lastActive,
    required this.status,
  });

  // TODO [BACKEND API / IAM]: Add fromJson / toJson to match your IAM user DTO
  @override
  List<Object?> get props => [id, name, email, role, lastActive, status];
}
