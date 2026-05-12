import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../providers/cart_providers.dart';

/// Página do Carrinho
class CartPage extends ConsumerWidget {
  final int restauranteId;

  const CartPage({
    super.key,
    required this.restauranteId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Carrinho'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: EmptyStateWidget(
              icon: Icons.shopping_cart_outlined,
              title: 'Carrinho Vazio',
              message: 'Adicione itens ao seu carrinho para continuar.',
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        elevation: 1,
      ),
      body: Column(
        children: [
          // Lista de itens
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppTheme.paddingMedium),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: AppTheme.paddingMedium),
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.produto.nome,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: AppTheme.paddingSmall,
                                  ),
                                  Text(
                                    'R\$ ${item.produto.preco.toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppTheme.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              color: AppTheme.errorColor,
                              onPressed: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .removeFromCart(item.produto.id);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.paddingMedium),
                        // Controle de quantidade
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal: R\$ ${item.subtotal.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(
                                          item.produto.id,
                                          item.quantidade - 1,
                                        );
                                  },
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: AppTheme.primaryColor,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.paddingMedium,
                                    vertical: AppTheme.paddingSmall,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppTheme.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusSmall,
                                    ),
                                  ),
                                  child: Text(
                                    '${item.quantidade}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(
                                          item.produto.id,
                                          item.quantidade + 1,
                                        );
                                  },
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: AppTheme.primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Resumo e botão de finalizar
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingLarge),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'R\$ ${total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.paddingLarge),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/checkout/$restauranteId');
                      },
                      child: const Text('Finalizar Pedido'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


