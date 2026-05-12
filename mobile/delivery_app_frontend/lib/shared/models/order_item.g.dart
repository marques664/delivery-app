// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  id: (json['id'] as num?)?.toInt(),
  quantidade: (json['quantidade'] as num).toInt(),
  produto: Product.fromJson(json['produto'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.id,
  'quantidade': instance.quantidade,
  'produto': instance.produto,
};
