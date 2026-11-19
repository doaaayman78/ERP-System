import '../models/user_model.dart';
import '../../../../core/config/navigation_config.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<List<UserModel>> getUsers();
  Future<UserModel> addUser({
    required String name,
    required String email,
    required UserRole role,
  });
}
