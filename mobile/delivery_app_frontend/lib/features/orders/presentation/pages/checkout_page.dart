import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../providers/order_providers.dart';

/// Página de Checkout - Finalizar Pedido
class CheckoutPage extends ConsumerWidget {
  final int restauranteId;

  const CheckoutPage({
    super.key,
    required this.restauranteId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);
    final orderCreationState = ref.watch(orderCreationProvider);

    ref.listen(orderCreationProvider, (previous, next) {
      next.when(
        data: (order) {
          if (order != null) {
            // Pedido criado com sucesso
            // Limpa o carrinho
            ref.read(cartProvider.notifier).clearCart();

            // Mostra mensagem de sucesso
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Pedido criado com sucesso!'),
                backgroundColor: AppTheme.successColor,
                duration: const Duration(seconds: 2),
              ),
            );

            // Navega para tela de acompanhamento
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                context.pushReplacementNamed(
                  'order_tracking',
                  pathParameters: {'id': (order.id ?? 0).toString()},
                );
              }
            });
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao criar pedido: $error'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Pedido'),
        elevation: 1,
      ),
      body: orderCreationState.maybeWhen(
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.paddingLarge),
            child: LoadingWidget(
              message: 'Processando seu pedido...',
            ),
          ),
        ),
        orElse: () => SingleChildScrollView(
          child: Column(
            children: [
              // Itens do pedido
              Container(
                padding: const EdgeInsets.all(AppTheme.paddingMedium),
                color: AppTheme.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Itens do Pedido',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    ...cartItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppTheme.paddingMedium,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.produto.nome,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Qty: ${item.quantidade} × R\$ ${item.produto.preco.toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'R\$ ${item.subtotal.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              // Total
              Container(
                padding: const EdgeInsets.all(AppTheme.paddingMedium),
                margin: const EdgeInsets.all(AppTheme.paddingMedium),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.borderColor),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleMedium,
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
              ),
              // Informações adicionais
              Container(
                padding: const EdgeInsets.all(AppTheme.paddingMedium),
                margin: const EdgeInsets.symmetric(
                  horizontal: AppTheme.paddingMedium,
                  vertical: AppTheme.paddingMedium,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accentLight,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppTheme.accentColor,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.paddingSmall),
                        Text(
                          'Total de itens: ${cartItems.fold(0, (sum, item) => sum + item.quantidade)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_shipping_outlined,
                          color: AppTheme.accentColor,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.paddingSmall),
                        Expanded(
                          child: Text(
                            'Você será notificado quando seu pedido sair para entrega',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.paddingLarge),
            ],
          ),
        ),
      ),
      bottomNavigationBar: orderCreationState.maybeWhen(
        loading: () => const SizedBox.shrink(),
        orElse: () => Container(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(orderCreationProvider.notifier).createOrder(
                        restauranteId: restauranteId,
                        itens: cartItems,
                      );
                    },
                    child: const Text('Confirmar Pedido'),
                  ),
                ),
                const SizedBox(height: AppTheme.paddingMedium),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Voltar ao Carrinho'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





