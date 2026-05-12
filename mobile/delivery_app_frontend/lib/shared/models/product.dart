import 'package:json_annotation/json_annotation.dart';
import 'restaurant.dart';

part 'product.g.dart';

/// Modelo de Produto
@JsonSerializable()
class Product {
  final int id;
  final String nome;
  final double preco;

  @JsonKey(name: 'restaurante')
  final Restaurant? restaurante;

  Product({
    required this.id,
    required this.nome,
    required this.preco,
    this.restaurante,
  });

  /// Converte JSON em Product
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// Converte Product em JSON
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  /// Cria uma cópia com valores opcionais modificados
  Product copyWith({
    int? id,
    String? nome,
    double? preco,
    Restaurant? restaurante,
  }) {
    return Product(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      restaurante: restaurante ?? this.restaurante,
    );
  }

  @override
  String toString() =>
      'Product(id: $id, nome: $nome, preco: $preco, restaurante: $restaurante)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nome == other.nome &&
          preco == other.preco &&
          restaurante == other.restaurante;

  @override
  int get hashCode =>
      id.hashCode ^ nome.hashCode ^ preco.hashCode ^ restaurante.hashCode;
}

