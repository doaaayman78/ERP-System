import 'package:dio/dio.dart';
import '../config/env_config.dart';

/// Centralized HTTP client for communicating with the Backend API Gateway.
/// Remote repository implementations should inject and use `ApiClient`.
class ApiClient {
  late final Dio dio;
  String? _authToken;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO [BACKEND API / IAM]: Attach JWT Bearer token issued by the IAM service
          if (_authToken != null && _authToken!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // TODO [BACKEND API / IAM]: Handle 401 token expiry/refresh or map ProblemDetails errors
          return handler.next(error);
        },
      ),
    );
  }

  void setAuthToken(String? token) {
    _authToken = token;
  }
}
