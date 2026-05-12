import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/restaurant.dart';
import '../../../../shared/providers/service_providers.dart';

/// Estado para lista de restaurantes
final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  final restaurantService = ref.watch(restaurantServiceProvider);
  return restaurantService.getRestaurants();
});

/// Provider para recarregar restaurantes
final refreshRestaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  final restaurantService = ref.watch(restaurantServiceProvider);
  return restaurantService.getRestaurants();
});


