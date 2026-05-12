import 'package:dio/dio.dart';
import '../../shared/models/restaurant.dart';
import '../../core/constants/api_constants.dart';

/// Serviço para operações de Restaurante
/// Responsável por toda comunicação HTTP com a API de restaurantes
class RestaurantService {
  final Dio dio;

  RestaurantService(this.dio);

  /// Obtém lista de todos os restaurantes
  ///
  /// Lança [DioException] em caso de erro
  /// Retorna lista de [Restaurant]
  Future<List<Restaurant>> getRestaurants() async {
    try {
      final response = await dio.get(ApiConstants.restaurantes);

      final List<dynamic> data = response.data;
      return data
          .map((json) => Restaurant.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException {
      rethrow;
    }
  }

  /// Cria um novo restaurante
  ///
  /// Requer [nome] e [endereco]
  /// Lança [DioException] em caso de erro
  /// Retorna o [Restaurant] criado
  Future<Restaurant> createRestaurant({
    required String nome,
    required String endereco,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.restaurantes,
        data: {
          'nome': nome,
          'endereco': endereco,
        },
      );

      return Restaurant.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }

  /// Obtém um restaurante específico pelo ID
  ///
  /// Lança [DioException] em caso de erro
  /// Retorna o [Restaurant] encontrado
  Future<Restaurant> getRestaurantById(int id) async {
    try {
      final response = await dio.get('${ApiConstants.restaurantes}/$id');
      return Restaurant.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }
}

