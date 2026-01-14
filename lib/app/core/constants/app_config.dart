/// Configurações do aplicativo
class AppConfig {
  // Configurações gerais
  static const bool enableDebugLogging = true;
  static const bool enablePerformanceMonitoring = false;

  // Configurações de simulação de rede
  static const Duration networkDelay = Duration(milliseconds: 500);
  static const double successRate = 0.95; // 95% de taxa de sucesso

  /// Retorna se deve mostrar logs de debug
  static bool get shouldShowDebugLogs => enableDebugLogging;
}
