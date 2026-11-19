/// Environment and compile-time configuration for AURA ERP Web.
/// Pass values via --dart-define when running locally or building Docker images.
class EnvConfig {
  // TODO [BACKEND API]: Replace defaultValue with your API Gateway base URL (e.g. http://api-gateway:8000/api)
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000/api',
  );

  // Supported flavors: 'dev', 'admin', 'employee'
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  // Set to false via --dart-define=USE_MOCK_DATA=false once backend endpoints are ready
  static const bool useMockData = bool.fromEnvironment(
    'USE_MOCK_DATA',
    defaultValue: true,
  );

  // TODO [POWER BI]: Inject the Power BI report embed URL via --dart-define=POWER_BI_EMBED_URL=...
  static const String powerBiEmbedUrl = String.fromEnvironment(
    'POWER_BI_EMBED_URL',
    defaultValue: '',
  );

  // TODO [AI SERVICE]: Inject AI / OCR service URL if exposed separately from the API Gateway
  static const String aiServiceBaseUrl = String.fromEnvironment(
    'AI_SERVICE_BASE_URL',
    defaultValue: '',
  );

  static bool get isAdminFlavor => flavor == 'admin';
  static bool get isEmployeeFlavor => flavor == 'employee';
  static bool get isDevFlavor => flavor == 'dev';
}
