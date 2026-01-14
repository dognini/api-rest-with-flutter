enum EnvironmentEnum {
  production(
    type: 'production',
  ),
  development(
    type: 'development',
  );

  const EnvironmentEnum({
    required this.type,
  });

  final String type;

  EnvironmentEnum envFromString(String value) {
    switch (value) {
      case "PROD":
        return EnvironmentEnum.production;
      case "DEV":
        return EnvironmentEnum.development;
      default:
        throw ArgumentError("Invalid status string: $value");
    }
  }
}

extension EnvironmentsEnumMethods on EnvironmentEnum {
  static EnvironmentEnum envFromString(String value) {
    switch (value) {
      case "PROD":
        return EnvironmentEnum.production;
      case "DEV":
        return EnvironmentEnum.development;
      default:
        throw ArgumentError("Invalid status string: $value");
    }
  }
}
