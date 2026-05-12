import 'package:json_annotation/json_annotation.dart';
import 'product.dart';

part 'order_item.g.dart';

/// Modelo de Item do Pedido
@JsonSerializable()
class OrderItem {
  final int? id;
  final int quantidade;
  final Product produto;

  OrderItem({
    this.id,
    required this.quantidade,
    required this.produto,
  });

  /// Converte JSON em OrderItem
  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  /// Converte OrderItem em JSON
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  /// Cria uma cópia com valores opcionais modificados
  OrderItem copyWith({
    int? id,
    int? quantidade,
    Product? produto,
  }) {
    return OrderItem(
      id: id ?? this.id,
      quantidade: quantidade ?? this.quantidade,
      produto: produto ?? this.produto,
    );
  }

  /// Calcula o total do item (preço * quantidade)
  double get subtotal => produto.preco * quantidade;

  @override
  String toString() =>
      'OrderItem(id: $id, quantidade: $quantidade, produto: $produto)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          quantidade == other.quantidade &&
          produto == other.produto;

  @override
  int get hashCode => id.hashCode ^ quantidade.hashCode ^ produto.hashCode;
}

