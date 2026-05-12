import 'package:dio/dio.dart';
import '../../shared/models/product.dart';
import '../../core/constants/api_constants.dart';

/// Serviço para operações de Produto
/// Responsável por toda comunicação HTTP com a API de produtos
class ProductService {
  final Dio dio;

  ProductService(this.dio);

  /// Obtém lista de todos os produtos
  ///
  /// Lança [DioException] em caso de erro
  /// Retorna lista de [Product]
  Future<List<Product>> getProducts() async {
    try {
      final response = await dio.get(ApiConstants.produtos);

      final List<dynamic> data = response.data;
      return data
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException {
      rethrow;
    }
  }

  /// Obtém produtos de um restaurante específico
  ///
  /// Requer [restauranteId]
  /// Lança [DioException] em caso de erro
  /// Retorna lista de [Product] do restaurante
  Future<List<Product>> getProductsByRestaurant(int restauranteId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.produtosPorRestaurante}/$restauranteId',
      );

      final List<dynamic> data = response.data;
      return data
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException {
      rethrow;
    }
  }

  /// Cria um novo produto
  ///
  /// Requer [nome], [preco] e [restauranteId]
  /// Lança [DioException] em caso de erro
  /// Retorna o [Product] criado
  Future<Product> createProduct({
    required String nome,
    required double preco,
    required int restauranteId,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.produtos,
        data: {
          'nome': nome,
          'preco': preco,
          'restaurante': {
            'id': restauranteId,
          },
        },
      );

      return Product.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }

  /// Obtém um produto específico pelo ID
  ///
  /// Lança [DioException] em caso de erro
  /// Retorna o [Product] encontrado
  Future<Product> getProductById(int id) async {
    try {
      final response = await dio.get('${ApiConstants.produtos}/$id');
      return Product.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }
}

