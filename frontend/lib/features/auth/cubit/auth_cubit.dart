import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/config/env_config.dart';
import '../../../core/config/navigation_config.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(const AuthState()) {
    _bootstrapDefaultUser();
  }

  Future<void> _bootstrapDefaultUser() async {
    final users = await _repository.getUsers();
    final defaultRole = EnvConfig.isEmployeeFlavor ? UserRole.salesEmployee : UserRole.admin;
    final defaultUser = users.firstWhere(
      (u) => u.role == defaultRole,
      orElse: () => users.first,
    );
    emit(state.copyWith(currentUser: defaultUser, users: users));
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    final user = await _repository.login(email, password);
    final users = await _repository.getUsers();
    emit(state.copyWith(currentUser: user, users: users, isLoading: false));
  }

  void logout() {
    emit(state.copyWith(clearUser: true));
  }

  void switchRoleForTesting(UserRole role) {
    final current = state.currentUser;
    if (current == null) return;
    emit(state.copyWith(
      currentUser: UserModel(
        id: current.id,
        name: '${role.displayName} (Preview)',
        email: current.email,
        role: role,
        lastActive: 'Now',
        status: 'Active',
      ),
    ));
  }

  void setSearch(String query) => emit(state.copyWith(searchQuery: query));
  void setRoleFilter(String? filter) => emit(state.copyWith(roleFilter: filter ?? 'All'));

  Future<void> addUser(String name, String email, UserRole role) async {
    await _repository.addUser(name: name, email: email, role: role);
    final users = await _repository.getUsers();
    emit(state.copyWith(users: users));
  }
}
