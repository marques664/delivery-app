import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Widget raiz da aplicação
/// Configuração de tema, roteamento e providers
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme(),
      routerConfig: AppRoutes.createRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}
