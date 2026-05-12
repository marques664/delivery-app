import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

/// Modelo de Restaurante
@JsonSerializable()
class Restaurant {
  final int id;
  final String nome;
  final String endereco;

  Restaurant({
    required this.id,
    required this.nome,
    required this.endereco,
  });

  /// Converte JSON em Restaurant
  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  /// Converte Restaurant em JSON
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  /// Cria uma cópia com valores opcionais modificados
  Restaurant copyWith({
    int? id,
    String? nome,
    String? endereco,
  }) {
    return Restaurant(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      endereco: endereco ?? this.endereco,
    );
  }

  @override
  String toString() => 'Restaurant(id: $id, nome: $nome, endereco: $endereco)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Restaurant &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nome == other.nome &&
          endereco == other.endereco;

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ endereco.hashCode;
}

