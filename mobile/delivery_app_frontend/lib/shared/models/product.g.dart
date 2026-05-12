// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: (json['id'] as num).toInt(),
  nome: json['nome'] as String,
  preco: (json['preco'] as num).toDouble(),
  restaurante: json['restaurante'] == null
      ? null
      : Restaurant.fromJson(json['restaurante'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'nome': instance.nome,
  'preco': instance.preco,
  'restaurante': instance.restaurante,
};
