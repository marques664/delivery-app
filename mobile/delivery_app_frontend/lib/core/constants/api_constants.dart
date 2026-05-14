/// Constantes da API
class ApiConstants {
  /// URL base do backend
  /// 
  /// Configure conforme seu ambiente:
  /// 
  /// DESENVOLVIMENTO LOCAL:
  /// static const String baseUrl = 'http://localhost:8080';
  /// 
  /// DISPOSITIVO NA MESMA REDE:
  /// Encontre o IP do seu computador (ipconfig no CMD) e use:
  /// static const String baseUrl = 'http://192.168.x.x:8080';
  /// 
  /// PRODUÇÃO:
  /// static const String baseUrl = 'https://seu-dominio.com';
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

