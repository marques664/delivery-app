// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String,
  total: (json['total'] as num).toDouble(),
  restaurante: Restaurant.fromJson(json['restaurante'] as Map<String, dynamic>),
  itens: (json['itens'] as List<dynamic>)
      .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'total': instance.total,
  'restaurante': instance.restaurante,
  'itens': instance.itens,
};
