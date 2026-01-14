/// Classe base para representar respostas de operações
abstract class Response {
  const Response();

  /// Indica se a operação foi bem-sucedida
  bool get isSuccess;

  /// Mensagem de erro (se houver)
  String? get message;
}

/// Resposta de sucesso
class Success extends Response {
  const Success();

  @override
  bool get isSuccess => true;

  @override
  String? get message => null;
}

/// Resposta de falha geral
class GeneralFailure extends Response {
  final String? _message;

  const GeneralFailure({String? message}) : _message = message;

  @override
  bool get isSuccess => false;

  @override
  String? get message => _message ?? 'Erro geral';
}

/// Resposta de falha de conexão
class ConnectionFailure extends Response {
  final String? _message;

  const ConnectionFailure({String? message}) : _message = message;

  @override
  bool get isSuccess => false;

  @override
  String? get message => _message ?? 'Erro de conexão';
}
