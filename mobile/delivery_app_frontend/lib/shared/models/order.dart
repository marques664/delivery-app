import 'package:json_annotation/json_annotation.dart';
import 'restaurant.dart';
import 'order_item.dart';

part 'order.g.dart';

/// Modelo de Pedido
@JsonSerializable()
class Order {
  final int? id;
  final String status;
  final double total;
  final Restaurant restaurante;
  final List<OrderItem> itens;

  Order({
    this.id,
    required this.status,
    required this.total,
    required this.restaurante,
    required this.itens,
  });

  /// Converte JSON em Order
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// Converte Order em JSON
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  /// Cria uma cópia com valores opcionais modificados
  Order copyWith({
    int? id,
    String? status,
    double? total,
    Restaurant? restaurante,
    List<OrderItem>? itens,
  }) {
    return Order(
      id: id ?? this.id,
      status: status ?? this.status,
      total: total ?? this.total,
      restaurante: restaurante ?? this.restaurante,
      itens: itens ?? this.itens,
    );
  }

  /// Retorna a quantidade total de itens no pedido
  int get totalItems => itens.fold(0, (sum, item) => sum + item.quantidade);

  @override
  String toString() =>
      'Order(id: $id, status: $status, total: $total, restaurante: $restaurante, itens: $itens)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          status == other.status &&
          total == other.total &&
          restaurante == other.restaurante &&
          itens == other.itens;

  @override
  int get hashCode =>
      id.hashCode ^
      status.hashCode ^
      total.hashCode ^
      restaurante.hashCode ^
      itens.hashCode;
}

