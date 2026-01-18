import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../group/domain/converters/timestamp_converter.dart';

part 'shopping_list.freezed.dart';
part 'shopping_list.g.dart';

@freezed
abstract class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required String id,
    required String name,
    @Default(0) int order,
    @Default(false) bool archived,
    @TimestampConverter() DateTime? updatedAt,
    required String updatedBy,
  }) = _ShoppingList;

  factory ShoppingList.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListFromJson(json);
}

@freezed
abstract class ShoppingItem with _$ShoppingItem {
  const factory ShoppingItem({
    required String id,
    required String name,
    @Default(1) int quantity,
    String? note,
    String? category,
    @Default('active') String status, // 'active' | 'bought'
    @TimestampConverter() DateTime? updatedAt,
    required String updatedBy,
    @Default(0) int order,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? boughtAt,
  }) = _ShoppingItem;

  factory ShoppingItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemFromJson(json);
}
