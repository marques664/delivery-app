import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/product.dart';
import '../../../../shared/providers/service_providers.dart';

/// Provider para obter produtos de um restaurante específico
final restaurantProductsProvider =
    FutureProvider.family<List<Product>, int>((ref, restauranteId) async {
  final productService = ref.watch(productServiceProvider);
  return productService.getProductsByRestaurant(restauranteId);
});


