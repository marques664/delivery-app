import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/cards_widget.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../providers/product_providers.dart';

/// Página de Detalhes do Restaurante - Lista de Produtos
class RestaurantDetailPage extends ConsumerWidget {
  final int restauranteId;
  final String? restauranteName;

  const RestaurantDetailPage({
    super.key,
    required this.restauranteId,
    this.restauranteName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(
      restaurantProductsProvider(restauranteId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(restauranteName ?? 'Restaurante'),
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.paddingMedium),
            child: Center(
              child: Consumer(
                builder: (context, ref, _) {
                  final cartItems = ref.watch(cartProvider);
                  return GestureDetector(
                    onTap: () {
                      context.push('/cart/$restauranteId');
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        if (cartItems.isNotEmpty)
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${cartItems.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: EmptyStateWidget(
                  icon: Icons.fastfood_outlined,
                  title: 'Sem Produtos',
                  message: 'Este restaurante não possui produtos disponíveis.',
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.paddingMedium),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                id: product.id,
                nome: product.nome,
                preco: product.preco,
                onTap: () {
                  // Pode adicionar navegação para detalhes do produto
                },
                onAdd: () {
                  // Adiciona o produto ao carrinho
                  ref.read(cartProvider.notifier).addToCart(product);

                  // Mostra um feedback visual
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.nome} adicionado ao carrinho'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const LoadingWidget(
          message: 'Carregando produtos...',
        ),
        error: (error, stackTrace) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ErrorDisplayWidget(
              icon: Icons.error_outline,
              title: 'Erro ao Carregar',
              message: 'Não conseguimos carregar os produtos. Tente novamente.',
              onRetry: () {
                ref.invalidate(
                  restaurantProductsProvider(restauranteId),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



