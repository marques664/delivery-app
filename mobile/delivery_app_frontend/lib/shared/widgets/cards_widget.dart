import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Card customizado para restaurante
class RestaurantCard extends StatelessWidget {
  final int id;
  final String nome;
  final String endereco;
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.id,
    required this.nome,
    required this.endereco,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.paddingMedium),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem placeholder
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 48,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: AppTheme.paddingMedium),
              // Nome do restaurante
              Text(
                nome,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppTheme.paddingSmall),
              // Endereço
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
                      endereco,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card customizado para produto
class ProductCard extends StatelessWidget {
  final int id;
  final String nome;
  final double preco;
  final VoidCallback onTap;
  final VoidCallback? onAdd;

  const ProductCard({
    super.key,
    required this.id,
    required this.nome,
    required this.preco,
    required this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.paddingMedium),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem placeholder
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.accentLight,
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: const Icon(
                  Icons.fastfood,
                  size: 40,
                  color: AppTheme.accentColor,
                ),
              ),
              const SizedBox(height: AppTheme.paddingMedium),
              // Nome do produto
              Text(
                nome,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppTheme.paddingSmall),
              // Preço e botão
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'R\$ ${preco.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  if (onAdd != null)
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: AppTheme.primaryColor,
                      onPressed: onAdd,
                      iconSize: 28,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


