import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/cards_widget.dart';
import '../providers/restaurant_providers.dart';

/// Página Home - Lista de Restaurantes
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsAsync = ref.watch(restaurantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery App'),
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(restaurantsProvider);
        },
        child: restaurantsAsync.when(
          data: (restaurants) {
            if (restaurants.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: EmptyStateWidget(
                  icon: Icons.restaurant_outlined,
                  title: 'Nenhum Restaurante',
                  message:
                      'Não encontramos restaurantes disponíveis no momento.',
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(AppTheme.paddingMedium),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return RestaurantCard(
                  id: restaurant.id,
                  nome: restaurant.nome,
                  endereco: restaurant.endereco,
                  onTap: () {
                    // Navega para tela de detalhes do restaurante
                    context.push('/restaurant/${restaurant.id}');
                  },
                );
              },
            );
          },
          loading: () => const LoadingWidget(
            message: 'Carregando restaurantes...',
          ),
          error: (error, stackTrace) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ErrorDisplayWidget(
                icon: Icons.error_outline,
                title: 'Erro ao Carregar',
                message:
                    'Não conseguimos carregar os restaurantes. Tente novamente.',
                onRetry: () {
                  ref.invalidate(restaurantsProvider);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}


