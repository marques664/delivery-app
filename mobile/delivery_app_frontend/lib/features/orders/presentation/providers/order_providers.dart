import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../shared/models/order.dart';
import '../../../../shared/models/order_item.dart';
import '../../../../shared/services/order_service.dart';
import '../../../../shared/providers/service_providers.dart';

/// Notifier para gerenciar o estado de criação de pedido
class OrderCreationNotifier extends StateNotifier<AsyncValue<Order?>> {
  final OrderService orderService;

  OrderCreationNotifier(this.orderService) : super(const AsyncValue.data(null));

  /// Cria um novo pedido
  Future<void> createOrder({
    required int restauranteId,
    required List<OrderItem> itens,
  }) async {
    state = const AsyncValue.loading();
    try {
      final order = await orderService.createOrder(
        restauranteId: restauranteId,
        itens: itens,
      );
      state = AsyncValue.data(order);
    } on DioException catch (e) {
      state = AsyncValue.error(e.message ?? 'Erro ao criar pedido', StackTrace.current);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  /// Reseta o estado
  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Provider para criar pedidos
final orderCreationProvider =
    StateNotifierProvider<OrderCreationNotifier, AsyncValue<Order?>>((ref) {
  final orderService = ref.watch(orderServiceProvider);
  return OrderCreationNotifier(orderService);
});



