import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Widget para exibir erros
class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorDisplayWidget({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: AppTheme.paddingLarge),
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.errorColor,
                    ),
              ),
            const SizedBox(height: AppTheme.paddingMedium),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppTheme.paddingLarge),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar Novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Widget para exibir estado vazio
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData icon;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: AppTheme.paddingLarge),
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            const SizedBox(height: AppTheme.paddingMedium),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


