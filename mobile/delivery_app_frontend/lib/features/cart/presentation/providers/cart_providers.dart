import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/product.dart';
import '../../../../shared/models/order_item.dart';

/// Notifier para gerenciar o carrinho
class CartNotifier extends StateNotifier<List<OrderItem>> {
  CartNotifier() : super([]);

  /// Adiciona um produto ao carrinho
  /// Se o produto já existe, incrementa a quantidade
  void addToCart(Product product) {
    final existingIndex =
        state.indexWhere((item) => item.produto.id == product.id);

    if (existingIndex >= 0) {
      // Produto já está no carrinho - incrementar quantidade
      final updatedItem = state[existingIndex].copyWith(
        quantidade: state[existingIndex].quantidade + 1,
      );

      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // Novo produto - adicionar ao carrinho
      state = [
        ...state,
        OrderItem(
          quantidade: 1,
          produto: product,
        ),
      ];
    }
  }

  /// Remove um produto do carrinho
  void removeFromCart(int productId) {
    state = state.where((item) => item.produto.id != productId).toList();
  }

  /// Atualiza a quantidade de um produto
  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
    } else {
      final existingIndex =
          state.indexWhere((item) => item.produto.id == productId);

      if (existingIndex >= 0) {
        final updatedItem = state[existingIndex].copyWith(
          quantidade: quantity,
        );

        state = [
          ...state.sublist(0, existingIndex),
          updatedItem,
          ...state.sublist(existingIndex + 1),
        ];
      }
    }
  }

  /// Limpa o carrinho
  void clearCart() {
    state = [];
  }

  /// Calcula o total do carrinho
  double getTotal() {
    return state.fold(0, (total, item) => total + item.subtotal);
  }
}

/// Provider do carrinho
final cartProvider =
    StateNotifierProvider<CartNotifier, List<OrderItem>>((ref) {
  return CartNotifier();
});

/// Provider para calcular o total do carrinho
final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (total, item) => total + item.subtotal);
});

/// Provider para contar itens no carrinho
final cartItemsCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantidade);
});


