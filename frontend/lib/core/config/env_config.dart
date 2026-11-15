class EnvConfig{
  // Reads the backend URL injected by Docker, defaults to local dev
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000/api',
  );

  // Identifies which flavor is currently running
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static bool get isAdmin => flavor == 'admin';
  static bool get isEmployee => flavor == 'employee';
}