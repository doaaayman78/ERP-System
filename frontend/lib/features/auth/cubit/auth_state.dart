import 'package:equatable/equatable.dart';
import '../data/models/user_model.dart';

class AuthState extends Equatable {
  final UserModel? currentUser;
  final List<UserModel> users;
  final String searchQuery;
  final String roleFilter;
  final bool isLoading;

  const AuthState({
    this.currentUser,
    this.users = const [],
    this.searchQuery = '',
    this.roleFilter = 'All',
    this.isLoading = false,
  });

  bool get isAuthenticated => currentUser != null;

  List<UserModel> get filteredUsers {
    return users.where((u) {
      final matchesSearch = searchQuery.isEmpty ||
          u.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          u.email.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesRole = roleFilter == 'All' || u.role.displayName == roleFilter;
      return matchesSearch && matchesRole;
    }).toList();
  }

  AuthState copyWith({
    UserModel? currentUser,
    bool clearUser = false,
    List<UserModel>? users,
    String? searchQuery,
    String? roleFilter,
    bool? isLoading,
  }) {
    return AuthState(
      currentUser: clearUser ? null : (currentUser ?? this.currentUser),
      users: users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
      roleFilter: roleFilter ?? this.roleFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [currentUser, users, searchQuery, roleFilter, isLoading];
}
