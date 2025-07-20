enum Environment {
  dev(
    baseUrl: 'https://6266f62263e0f382568936e4.dev.mockapi.io/',
  ),
  uat(
    baseUrl: 'https://6266f62263e0f382568936e4.uat.mockapi.io/',
  ),
  prd(
    baseUrl: 'https://6266f62263e0f382568936e4.mockapi.io/',
  );

  final String baseUrl;
  final int httpTimeout;

  const Environment({
    required this.baseUrl,
    this.httpTimeout = 60000,
  });

  factory Environment.fromValue(String value) {
    return Environment.values.firstWhere(
      (env) => env.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Environment.prd,
    );
  }
}

final class EnvironmentConfig {
  EnvironmentConfig._();

  static EnvironmentConfig get instance => EnvironmentConfig._();

  Environment env = Environment.prd;

  Environment get setupEnvironment {
    const envString = String.fromEnvironment('ENV', defaultValue: 'prd');
    env = Environment.fromValue(envString);
    return env;
  }
}
