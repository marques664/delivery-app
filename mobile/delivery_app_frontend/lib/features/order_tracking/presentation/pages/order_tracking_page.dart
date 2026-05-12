import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../providers/order_tracking_providers.dart';

/// Página de Acompanhamento do Pedido
class OrderTrackingPage extends ConsumerWidget {
  final int orderId;

  const OrderTrackingPage({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderTrackingProvider(orderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acompanhar Pedido'),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(orderTrackingProvider(orderId));
        },
        child: orderAsync.when(
          data: (order) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Número do pedido
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.paddingMedium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pedido #${order.id}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                ),
                                const SizedBox(
                                  height: AppTheme.paddingSmall,
                                ),
                                Text(
                                  'Total: R\$ ${order.total.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: AppTheme.primaryColor,
                                      ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.receipt_long,
                              size: 32,
                              color: AppTheme.accentColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingLarge),

                    // Timeline de status
                    Text(
                      'Status do Pedido',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    _buildStatusTimeline(context, order.status),
                    const SizedBox(height: AppTheme.paddingLarge),

                    // Restaurante
                    Text(
                      'Restaurante',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.paddingMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.restaurante.nome,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: AppTheme.paddingSmall),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: AppTheme.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    order.restaurante.endereco,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingLarge),

                    // Itens do pedido
                    Text(
                      'Itens',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    ...order.itens.map((item) {
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
                                  ),
                                  Text(
                                    'Quantidade: ${item.quantidade}',
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
            );
          },
          loading: () => const LoadingWidget(
            message: 'Carregando pedido...',
          ),
          error: (error, stackTrace) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ErrorDisplayWidget(
                icon: Icons.error_outline,
                title: 'Erro ao Carregar',
                message:
                    'Não conseguimos carregar os dados do pedido. Tente novamente.',
                onRetry: () {
                  ref.invalidate(orderTrackingProvider(orderId));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Constrói a timeline visual do status do pedido
  Widget _buildStatusTimeline(BuildContext context, String currentStatus) {
    final statuses = [
      {
        'key': AppConstants.orderStatusCreated,
        'label': 'Pedido Criado',
        'icon': Icons.check_circle_outline,
      },
      {
        'key': AppConstants.orderStatusPreparing,
        'label': 'Preparando',
        'icon': Icons.local_fire_department_outlined,
      },
      {
        'key': AppConstants.orderStatusInDelivery,
        'label': 'Saiu para Entrega',
        'icon': Icons.two_wheeler,
      },
      {
        'key': AppConstants.orderStatusDelivered,
        'label': 'Entregue',
        'icon': Icons.home,
      },
    ];

    return Column(
      children: List.generate(
        statuses.length,
        (index) {
          final status = statuses[index];
          final isCompleted = _isStatusCompleted(
            currentStatus,
            status['key'] as String,
          );
          final isCurrent = status['key'] == currentStatus;

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? AppTheme.successColor
                          : isCurrent
                              ? AppTheme.primaryColor
                              : AppTheme.borderColor,
                    ),
                    child: Icon(
                      status['icon'] as IconData,
                      color: isCompleted || isCurrent
                          ? Colors.white
                          : AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppTheme.paddingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status['label'] as String,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (isCurrent)
                          Text(
                            'Em andamento',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: AppTheme.primaryColor,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (index < statuses.length - 1)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    top: AppTheme.paddingSmall,
                    bottom: AppTheme.paddingMedium,
                  ),
                  child: Container(
                    width: 2,
                    height: 30,
                    color: isCompleted
                        ? AppTheme.successColor
                        : AppTheme.borderColor,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  /// Verifica se um status foi concluído
  bool _isStatusCompleted(String currentStatus, String statusKey) {
    final order = [
      AppConstants.orderStatusCreated,
      AppConstants.orderStatusPreparing,
      AppConstants.orderStatusInDelivery,
      AppConstants.orderStatusDelivered,
    ];

    final currentIndex = order.indexOf(currentStatus);
    final statusIndex = order.indexOf(statusKey);

    return statusIndex < currentIndex;
  }
}


