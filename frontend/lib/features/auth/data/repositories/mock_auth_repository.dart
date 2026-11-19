import '../../../../core/config/navigation_config.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  final List<UserModel> _users = [
    const UserModel(
      id: 'U-101',
      name: 'Mahitab Admin',
      email: 'admin@aura-erp.local',
      role: UserRole.admin,
      lastActive: 'Today 7:12 PM',
      status: 'Active',
    ),
    const UserModel(
      id: 'U-102',
      name: 'Ahmed Hassan',
      email: 'ahmed@aura-erp.local',
      role: UserRole.salesEmployee,
      lastActive: 'Today 6:40 PM',
      status: 'Active',
    ),
    const UserModel(
      id: 'U-103',
      name: 'Mona Adel',
      email: 'mona@aura-erp.local',
      role: UserRole.warehouseEmployee,
      lastActive: 'Today 4:15 PM',
      status: 'Active',
    ),
    const UserModel(
      id: 'U-104',
      name: 'Omar Samir',
      email: 'omar@aura-erp.local',
      role: UserRole.accountant,
      lastActive: 'Yesterday',
      status: 'Invited',
    ),
  ];

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _users.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
      orElse: () => _users.first,
    );
  }

  @override
  Future<List<UserModel>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_users);
  }

  @override
  Future<UserModel> addUser({
    required String name,
    required String email,
    required UserRole role,
  }) async {
    final user = UserModel(
      id: 'U-${101 + _users.length}',
      name: name,
      email: email,
      role: role,
      lastActive: 'Just now',
      status: 'Active',
    );
    _users.insert(0, user);
    return user;
  }
}
