/// Constantes da API
class ApiConstants {
  /// URL base do backend
  /// Change to your backend URL
  static const String baseUrl = 'http://localhost:8080';

  /// Endpoints da API
  static const String restaurantes = '/restaurantes';
  static const String produtos = '/produtos';
  static const String produtosPorRestaurante = '/produtos/restaurante';
  static const String pedidos = '/pedidos';
  static const String pedidosStatus = '/pedidos';

  /// Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

