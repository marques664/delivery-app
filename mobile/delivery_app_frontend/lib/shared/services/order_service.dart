import 'package:dio/dio.dart';
import '../../shared/models/order.dart';
import '../../shared/models/order_item.dart';
import '../../core/constants/api_constants.dart';

/// Serviço para operações de Pedido
/// Responsável por toda comunicação HTTP com a API de pedidos
class OrderService {
  final Dio dio;

  OrderService(this.dio);

  /// Obtém lista de todos os pedidos
  ///
  /// Lança [DioException] em caso de erro
  /// Retorna lista de [Order]
  Future<List<Order>> getOrders() async {
    try {
      final response = await dio.get(ApiConstants.pedidos);

      final List<dynamic> data = response.data;
      return data
          .map((json) => Order.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException {
      rethrow;
    }
  }

  /// Obtém um pedido específico pelo ID
  ///
  /// Lança [DioException] em caso de erro
  /// Retorna o [Order] encontrado
  Future<Order> getOrderById(int id) async {
    try {
      final response = await dio.get('${ApiConstants.pedidos}/$id');
      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }

  /// Cria um novo pedido
  ///
  /// Requer [restauranteId] e [itens] (lista de OrderItem)
  /// Lança [DioException] em caso de erro
  /// Retorna o [Order] criado
  Future<Order> createOrder({
    required int restauranteId,
    required List<OrderItem> itens,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.pedidos,
        data: {
          'restaurante': {
            'id': restauranteId,
          },
          'itens': itens
              .map((item) => {
                    'produto': {
                      'id': item.produto.id,
                    },
                    'quantidade': item.quantidade,
                  })
              .toList(),
        },
      );

      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }

  /// Atualiza o status de um pedido
  ///
  /// Requer [orderId] e [status] (ex: 'PREPARANDO', 'SAIU_ENTREGA', 'ENTREGUE')
  /// Lança [DioException] em caso de erro
  /// Retorna o [Order] atualizado
  Future<Order> updateOrderStatus({
    required int orderId,
    required String status,
  }) async {
    try {
      final response = await dio.put(
        '${ApiConstants.pedidosStatus}/$orderId/status',
        queryParameters: {
          'status': status,
        },
      );

      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }
}

