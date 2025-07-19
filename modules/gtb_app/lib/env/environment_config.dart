enum Environment {
  dev,
  uat,
  prd;

  factory Environment.fromValue(String value) {
    return Environment.values.firstWhere(
      (env) => env.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Environment.prd,
    );
  }
}

final class EnvironmentConfig {
  final String baseUrl;
  final Environment environment;
  final int httpTimeout;

  EnvironmentConfig._({
    required this.baseUrl,
    this.environment = Environment.prd,
    this.httpTimeout = 60000,
  });

  factory EnvironmentConfig.dev() => EnvironmentConfig._(
    baseUrl: 'https://6266f62263e0f382568936e4.dev.mockapi.io/',
    environment: Environment.dev,
  );
  factory EnvironmentConfig.uat() => EnvironmentConfig._(
    baseUrl: 'https://6266f62263e0f382568936e4.uat.mockapi.io/',
    environment: Environment.dev,
  );
  factory EnvironmentConfig.prd() =>
      EnvironmentConfig._(baseUrl: 'https://6266f62263e0f382568936e4.mockapi.io/');

  static EnvironmentConfig get config {
    const envString = String.fromEnvironment('ENV', defaultValue: 'prd');
    final env = Environment.fromValue(envString);

    return switch (env) {
      Environment.dev => EnvironmentConfig.dev(),
      Environment.uat => EnvironmentConfig.uat(),
      Environment.prd => EnvironmentConfig.prd(),
    };
  }
}
