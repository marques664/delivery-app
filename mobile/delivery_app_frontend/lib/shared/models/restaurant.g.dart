// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
  id: (json['id'] as num).toInt(),
  nome: json['nome'] as String,
  endereco: json['endereco'] as String,
);

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'endereco': instance.endereco,
    };
