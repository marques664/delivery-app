import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/restaurant_detail/presentation/pages/restaurant_detail_page.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/orders/presentation/pages/checkout_page.dart';
import '../features/order_tracking/presentation/pages/order_tracking_page.dart';

/// Configuração de rotas do aplicativo
/// Utiliza GoRouter para navegação moderna e type-safe
class AppRoutes {
  static const String home = '/';
  static const String restaurant = '/restaurant/:id';
  static const String cart = '/cart/:restauranteId';
  static const String checkout = '/checkout/:restauranteId';
  static const String orderTracking = '/order/:id';

  /// Retorna a configuração do router
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        // Home - Lista de Restaurantes
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => const MaterialPage(
            child: HomePage(),
          ),
        ),

        // Detalhes do Restaurante - Lista de Produtos
        GoRoute(
          path: '/restaurant/:id',
          name: 'restaurant_detail',
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            final restauranteName = state.extra as String?;

            return MaterialPage(
              child: RestaurantDetailPage(
                restauranteId: id,
                restauranteName: restauranteName,
              ),
            );
          },
        ),

        // Carrinho
        GoRoute(
          path: '/cart/:restauranteId',
          name: 'cart',
          pageBuilder: (context, state) {
            final restauranteId = int.parse(state.pathParameters['restauranteId']!);

            return MaterialPage(
              child: CartPage(
                restauranteId: restauranteId,
              ),
            );
          },
        ),

        // Checkout - Finalizar Pedido
        GoRoute(
          path: '/checkout/:restauranteId',
          name: 'checkout',
          pageBuilder: (context, state) {
            final restauranteId = int.parse(state.pathParameters['restauranteId']!);

            return MaterialPage(
              child: CheckoutPage(
                restauranteId: restauranteId,
              ),
            );
          },
        ),

        // Acompanhamento de Pedido
        GoRoute(
          path: '/order/:id',
          name: 'order_tracking',
          pageBuilder: (context, state) {
            final orderId = int.parse(state.pathParameters['id']!);

            return MaterialPage(
              child: OrderTrackingPage(
                orderId: orderId,
              ),
            );
          },
        ),
      ],

      // Tratamento de erros
      errorPageBuilder: (context, state) => MaterialPage(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Erro'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Color(0xFFE74C3C),
                ),
                const SizedBox(height: 16),
                Text(
                  'Página não encontrada',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Voltar ao Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

