// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShoppingList _$ShoppingListFromJson(Map<String, dynamic> json) =>
    _ShoppingList(
      id: json['id'] as String,
      name: json['name'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      archived: json['archived'] as bool? ?? false,
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      updatedBy: json['updatedBy'] as String,
    );

Map<String, dynamic> _$ShoppingListToJson(_ShoppingList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'archived': instance.archived,
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'updatedBy': instance.updatedBy,
    };

_ShoppingItem _$ShoppingItemFromJson(Map<String, dynamic> json) =>
    _ShoppingItem(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      note: json['note'] as String?,
      category: json['category'] as String?,
      status: json['status'] as String? ?? 'active',
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      updatedBy: json['updatedBy'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      boughtAt: const TimestampConverter().fromJson(json['boughtAt']),
    );

Map<String, dynamic> _$ShoppingItemToJson(_ShoppingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'note': instance.note,
      'category': instance.category,
      'status': instance.status,
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'updatedBy': instance.updatedBy,
      'order': instance.order,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'boughtAt': const TimestampConverter().toJson(instance.boughtAt),
    };
