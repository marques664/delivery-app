# 🚀 Delivery App Frontend - Guia Completo de Setup

## 📖 Visão Geral

Você agora tem um **aplicativo Flutter profissional e escalável** para um sistema de delivery, totalmente arquitetado seguindo as melhores práticas da indústria.

## ✨ O Que Foi Construído

### ✅ Arquitetura Profissional
- **Clean Architecture Leve** com separação clara de camadas
- **Feature-First Organization** para escalabilidade
- **Modularização completa** - cada feature independente
- **Type-safety** em toda a aplicação

### ✅ State Management
- **Riverpod 2.6.0** - decidimos por ele vs Provider pelos motivos:
  - Type-safe com melhor suporte do compilador
  - Não precisa de BuildContext (mais flexível)
  - AsyncValue nativo para dados assíncronos
  - Scoping granular para cache e invalidação
  - Comunidade mais ativa

### ✅ HTTP Client
- **Dio 5.4.0** com interceptadores customizados
- **Logging automático** em development
- **Tratamento de erros** centralizado
- **Timeouts configuráveis**

### ✅ Roteamento
- **GoRouter 14.2.0** para navegação type-safe
- **Deep linking automático**
- **Tratamento de rotas** com error pages
- **Parâmetros type-safe**

### ✅ UI/UX
- **Design System completo** centralizado
- **Tema profissional** com cores, tipografia, espaçamento
- **Widgets reutilizáveis** para consistência
- **Loading states, error handling, empty states**

### ✅ Features Implementadas
1. **Home Screen** - Lista de restaurantes
2. **Restaurant Detail** - Cardápio e produtos
3. **Cart** - Gerenciamento completo do carrinho
4. **Checkout** - Resumo e confirmação de pedido
5. **Order Tracking** - Acompanhamento com timeline visual

## 🎯 Estrutura Final

```
delivery_app_frontend/
│
├── lib/
│   ├── config/
│   │   └── app_routes.dart           # Configuração de rotas (GoRouter)
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── api_constants.dart    # URLs e endpoints da API
│   │   │   └── app_constants.dart    # Constantes do aplicativo
│   │   └── theme/
│   │       └── app_theme.dart        # Design system centralizado
│   │
│   ├── shared/
│   │   ├── models/                   # Modelos de dados
│   │   │   ├── restaurant.dart
│   │   │   ├── product.dart
│   │   │   ├── order.dart
│   │   │   └── order_item.dart
│   │   ├── services/                 # Services HTTP
│   │   │   ├── restaurant_service.dart
│   │   │   ├── product_service.dart
│   │   │   └── order_service.dart
│   │   ├── providers/                # Providers Riverpod base
│   │   │   ├── dio_provider.dart
│   │   │   └── service_providers.dart
│   │   └── widgets/                  # Widgets reutilizáveis
│   │       ├── loading_widget.dart
│   │       ├── error_widget.dart
│   │       └── cards_widget.dart
│   │
│   ├── features/
│   │   ├── home/                     # Feature: Lista de restaurantes
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── home_page.dart
│   │   │       └── providers/
│   │   │           └── restaurant_providers.dart
│   │   │
│   │   ├── restaurant_detail/        # Feature: Detalhes restaurante
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── restaurant_detail_page.dart
│   │   │       └── providers/
│   │   │           └── product_providers.dart
│   │   │
│   │   ├── cart/                     # Feature: Carrinho
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── cart_page.dart
│   │   │       └── providers/
│   │   │           └── cart_providers.dart
│   │   │
│   │   ├── orders/                   # Feature: Criação de pedido
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── checkout_page.dart
│   │   │       └── providers/
│   │   │           └── order_providers.dart
│   │   │
│   │   └── order_tracking/           # Feature: Acompanhamento
│   │       └── presentation/
│   │           ├── pages/
│   │           │   └── order_tracking_page.dart
│   │           └── providers/
│   │               └── order_tracking_providers.dart
│   │
│   ├── main.dart                     # Ponto de entrada com Riverpod
│   └── pubspec.yaml                  # Dependências
│
├── ARCHITECTURE.md                   # Documentação detalhada
├── SETUP_GUIDE.md                    # Este arquivo
└── pubspec.lock                      # Lock de dependências
```

## 🚀 Como Começar

### 1️⃣ Configurar Backend
Editar `lib/core/constants/api_constants.dart`:
```dart
static const String baseUrl = 'http://seu-ip:8080';
```

### 2️⃣ Instalar Dependências
```bash
cd delivery_app_frontend
flutter pub get
flutter pub run build_runner build
```

### 3️⃣ Executar
```bash
flutter run
```

### 4️⃣ Build Para Produção
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 💡 Padrões & Convenções

### Provider para Dados (Read-Only)
```dart
final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  final service = ref.watch(restaurantServiceProvider);
  return service.getRestaurants();
});
```

### StateNotifier para Mutações (Write)
```dart
class CartNotifier extends StateNotifier<List<OrderItem>> {
  CartNotifier() : super([]);
  
  void addToCart(Product product) {
    state = [...state, OrderItem(...)];
  }
}

final cartProvider = StateNotifierProvider((ref) => CartNotifier());
```

### Consumir em Widget
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(restaurantsProvider);
    
    return restaurants.when(
      data: (items) => ...,
      loading: () => LoadingWidget(),
      error: (err, st) => ErrorWidget(),
    );
  }
}
```

### Error Handling
```dart
try {
  final response = await dio.get(url);
  return Restaurant.fromJson(response.data);
} on DioException catch (e) {
  print('Erro: ${e.message}');
  rethrow; // Riverpod captura automaticamente
}
```

## 🎨 Design System

| Elemento | Valor |
|----------|-------|
| Cor Primária | #FF6B6B (Vermelho) |
| Cor Secundária | #4D96FF (Azul) |
| Background | #FAFAFA (Cinza claro) |
| Sucesso | #2ECC71 (Verde) |
| Erro | #E74C3C (Vermelho) |
| Padding | 4, 8, 16, 24, 32px |
| Border Radius | 8, 12, 16dp |
| Tipografia | Material 3 |

## 🔄 Fluxo de Dados

```
UI (ConsumerWidget)
    ↓ (ref.watch)
Provider (Riverpod)
    ↓ (ref.watch serviceProvider)
Service (HTTP com Dio)
    ↓ (GET/POST)
Backend API (Spring Boot)
    ↓ (JSON Response)
Models (json_serializable)
    ↓ (fromJson/toJson)
Provider → UI Rebuild
```

## 📊 Fluxo do Aplicativo

```
1. Home (Lista restaurantes)
   ↓ (tap)
2. Restaurant Detail (Produtos/Cardápio)
   ↓ (add to cart)
3. Cart (Revisar items)
   ↓ (checkout)
4. Checkout (Confirmar pedido)
   ↓ (submit)
5. Order Tracking (Timeline de status)
   ↓ (refresh/pull)
   Status: CRIADO → PREPARANDO → SAIU_ENTREGA → ENTREGUE
```

## 🧪 Testing (Próximas implementações)

### Unit Test
```dart
test('adiciona produto ao carrinho', () {
  final container = ProviderContainer();
  container.read(cartProvider.notifier).addToCart(product);
  
  expect(container.read(cartProvider).length, 1);
});
```

### Widget Test
```dart
testWidgets('mostra resList', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  expect(find.byType(RestaurantCard), findsWidgets);
});
```

## 📦 Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  riverpod: ^2.6.0
  flutter_riverpod: ^2.6.0
  
  # HTTP Client
  dio: ^5.4.0
  
  # Routing
  go_router: ^14.2.0
  
  # Serialization
  json_serializable: ^6.8.0
  json_annotation: ^4.9.0
  freezed_annotation: ^2.4.1
  
  # Utilities
  intl: ^0.20.0
```

## 🐛 Debug

### Ativar Logging do Dio
✅ **Já está configurado** em `shared/providers/dio_provider.dart`
- Mostra todas as requisições HTTP
- Exibe headers, bodies e responses
- Útil para development

### DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### Analyze do Projeto
```bash
flutter analyze
```

### Verificar Dependências Desatualizadas
```bash
flutter pub outdated
```

## 🚨 Possíveis Problemas & Soluções

### Erro: `Target of URI doesn't exist`
**Solução**: Verifique os imports e paths relativos

### Erro: `Unable to load Dart VM`
**Solução**: `flutter clean` e `flutter pub get`

### Erro: `Module not found`
**Solução**: Execute `flutter pub run build_runner build --delete-conflicting-outputs`

### Erro: `ANDROID SDK not set`
**Solução**: Configure `local.properties` em `android/`

## 📚 Documentação Detalhada

Para documentação arquitetural completa, ver: `ARCHITECTURE.md`

## 📱 Requisitos do Sistema

- **Flutter**: 3.x
- **Dart**: 3.x
- **Android SDK**: 21+
- **Xcode**: 14+ (iOS)
- **iOS**: 11.0+

## 📝 Convenções de Código

```dart
// Naming
class MyClass {}           // PascalCase para classes
MyClass myVariable = ...;  // camelCase para variáveis
void myMethod() {}         // camelCase para métodos

// Imports - organize em grupos
import 'package:flutter/material.dart';

import 'package:riverpod/riverpod.dart';

import 'models/restaurant.dart';

// Trailing commas em listas multiline ✅
final items = [
  item1,
  item2,
  item3,
];

// Max 120 caracteres por linha
// Use comentários públicos (///) para documentação
```

## 🎯 Próximas Melhorias (Roadmap)

**Priority 1 - Core Features:**
- [ ] Autenticação com JWT
- [ ] Persistência local com Hive
- [ ] Testes unitários
- [ ] Testes de widget

**Priority 2 - Enhancement:**
- [ ] Notificações push (FCM)
- [ ] Múltiplos idiomas (i18n)
- [ ] Dark mode
- [ ] Animações avançadas

**Priority 3 - Advanced:**
- [ ] Offline-first com sincronização
- [ ] Analytics
- [ ] A/B testing
- [ ] Performance optimization

## 🤝 Contribute

1. Crie uma branch: `git checkout -b feature/nova-feature`
2. Commit: `git commit -am 'Add nova-feature'`
3. Push: `git push origin feature/nova-feature`
4. Open Pull Request

## 📞 Suporte

Para dúvidas:
1. Ver `ARCHITECTURE.md` para detalhes
2. Executar `flutter analyze` para verificar erros
3. Rodar `flutter test` para testes
4. Verificar `pubspec.yaml` para dependências

## 🔗 Referências Úteis

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Riverpod Docs](https://riverpod.dev)
- [Dio Package](https://pub.dev/packages/dio)
- [GoRouter Package](https://pub.dev/packages/go_router)

## 📄 Licença

MIT License - Sinta-se livre para usar e modificar

---

**Desenvolvido com ❤️ seguindo boas práticas profissionais**

**Versão**: 1.0.0  
**Data**: Maio 2026  
**Status**: ✅ Pronto para desenvolvimento  
**Arquitetura**: Clean Architecture + Feature-First  
**State Management**: Riverpod  
**HTTP Client**: Dio  
**Routing**: GoRouter

