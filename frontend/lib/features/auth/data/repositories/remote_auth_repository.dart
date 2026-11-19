import '../../../../core/config/navigation_config.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

/// TODO [BACKEND API / IAM]: Implement live HTTP calls to your IAM microservice endpoints.
class RemoteAuthRepository implements AuthRepository {
  final ApiClient _apiClient;

  RemoteAuthRepository(this._apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    // Example:
    // final response = await _apiClient.dio.post('/auth/login', data: {'email': email, 'password': password});
    // final token = response.data['token'] as String;
    // _apiClient.setAuthToken(token);
    // return UserModel(...);
    throw UnimplementedError('TODO [BACKEND API]: Connect POST /auth/login');
  }

  @override
  Future<List<UserModel>> getUsers() async {
    // Example: final response = await _apiClient.dio.get('/users');
    throw UnimplementedError('TODO [BACKEND API]: Connect GET /users');
  }

  @override
  Future<UserModel> addUser({
    required String name,
    required String email,
    required UserRole role,
  }) async {
    // Example: final response = await _apiClient.dio.post('/users', data: {...});
    throw UnimplementedError('TODO [BACKEND API]: Connect POST /users');
  }
}
