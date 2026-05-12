import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/restaurant_service.dart';
import '../services/product_service.dart';
import '../services/order_service.dart';
import 'dio_provider.dart';

/// Provider do RestaurantService
final restaurantServiceProvider = Provider<RestaurantService>((ref) {
  final dio = ref.watch(dioProvider);
  return RestaurantService(dio);
});

/// Provider do ProductService
final productServiceProvider = Provider<ProductService>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductService(dio);
});

/// Provider do OrderService
final orderServiceProvider = Provider<OrderService>((ref) {
  final dio = ref.watch(dioProvider);
  return OrderService(dio);
});

