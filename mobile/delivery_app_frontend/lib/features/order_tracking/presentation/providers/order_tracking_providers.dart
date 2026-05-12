import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/order.dart';
import '../../../../shared/providers/service_providers.dart';

/// Provider para obter um pedido específico
final orderTrackingProvider =
    FutureProvider.family<Order, int>((ref, orderId) async {
  final orderService = ref.watch(orderServiceProvider);
  return orderService.getOrderById(orderId);
});

/// Provider para recarregar o status do pedido
/// Pode ser usado com um intervalo para polling
final orderRefreshProvider =
    FutureProvider.family<Order, int>((ref, orderId) async {
  final orderService = ref.watch(orderServiceProvider);
  return orderService.getOrderById(orderId);
});


