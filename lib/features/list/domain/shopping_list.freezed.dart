// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShoppingList {

 String get id; String get name; int get order; bool get archived;@TimestampConverter() DateTime? get updatedAt; String get updatedBy;
/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingListCopyWith<ShoppingList> get copyWith => _$ShoppingListCopyWithImpl<ShoppingList>(this as ShoppingList, _$identity);

  /// Serializes this ShoppingList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingList&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,order,archived,updatedAt,updatedBy);

@override
String toString() {
  return 'ShoppingList(id: $id, name: $name, order: $order, archived: $archived, updatedAt: $updatedAt, updatedBy: $updatedBy)';
}


}

/// @nodoc
abstract mixin class $ShoppingListCopyWith<$Res>  {
  factory $ShoppingListCopyWith(ShoppingList value, $Res Function(ShoppingList) _then) = _$ShoppingListCopyWithImpl;
@useResult
$Res call({
 String id, String name, int order, bool archived,@TimestampConverter() DateTime? updatedAt, String updatedBy
});




}
/// @nodoc
class _$ShoppingListCopyWithImpl<$Res>
    implements $ShoppingListCopyWith<$Res> {
  _$ShoppingListCopyWithImpl(this._self, this._then);

  final ShoppingList _self;
  final $Res Function(ShoppingList) _then;

/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? order = null,Object? archived = null,Object? updatedAt = freezed,Object? updatedBy = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ShoppingList].
extension ShoppingListPatterns on ShoppingList {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShoppingList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShoppingList value)  $default,){
final _that = this;
switch (_that) {
case _ShoppingList():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShoppingList value)?  $default,){
final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int order,  bool archived, @TimestampConverter()  DateTime? updatedAt,  String updatedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
return $default(_that.id,_that.name,_that.order,_that.archived,_that.updatedAt,_that.updatedBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int order,  bool archived, @TimestampConverter()  DateTime? updatedAt,  String updatedBy)  $default,) {final _that = this;
switch (_that) {
case _ShoppingList():
return $default(_that.id,_that.name,_that.order,_that.archived,_that.updatedAt,_that.updatedBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int order,  bool archived, @TimestampConverter()  DateTime? updatedAt,  String updatedBy)?  $default,) {final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
return $default(_that.id,_that.name,_that.order,_that.archived,_that.updatedAt,_that.updatedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShoppingList implements ShoppingList {
  const _ShoppingList({required this.id, required this.name, this.order = 0, this.archived = false, @TimestampConverter() this.updatedAt, required this.updatedBy});
  factory _ShoppingList.fromJson(Map<String, dynamic> json) => _$ShoppingListFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  int order;
@override@JsonKey() final  bool archived;
@override@TimestampConverter() final  DateTime? updatedAt;
@override final  String updatedBy;

/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShoppingListCopyWith<_ShoppingList> get copyWith => __$ShoppingListCopyWithImpl<_ShoppingList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShoppingListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShoppingList&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,order,archived,updatedAt,updatedBy);

@override
String toString() {
  return 'ShoppingList(id: $id, name: $name, order: $order, archived: $archived, updatedAt: $updatedAt, updatedBy: $updatedBy)';
}


}

/// @nodoc
abstract mixin class _$ShoppingListCopyWith<$Res> implements $ShoppingListCopyWith<$Res> {
  factory _$ShoppingListCopyWith(_ShoppingList value, $Res Function(_ShoppingList) _then) = __$ShoppingListCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int order, bool archived,@TimestampConverter() DateTime? updatedAt, String updatedBy
});




}
/// @nodoc
class __$ShoppingListCopyWithImpl<$Res>
    implements _$ShoppingListCopyWith<$Res> {
  __$ShoppingListCopyWithImpl(this._self, this._then);

  final _ShoppingList _self;
  final $Res Function(_ShoppingList) _then;

/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? order = null,Object? archived = null,Object? updatedAt = freezed,Object? updatedBy = null,}) {
  return _then(_ShoppingList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ShoppingItem {

 String get id; String get name; int get quantity; String? get note; String? get category; String get status;// 'active' | 'bought'
@TimestampConverter() DateTime? get updatedAt; String get updatedBy; int get order;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get boughtAt;
/// Create a copy of ShoppingItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingItemCopyWith<ShoppingItem> get copyWith => _$ShoppingItemCopyWithImpl<ShoppingItem>(this as ShoppingItem, _$identity);

  /// Serializes this ShoppingItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.order, order) || other.order == order)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.boughtAt, boughtAt) || other.boughtAt == boughtAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,quantity,note,category,status,updatedAt,updatedBy,order,createdAt,boughtAt);

@override
String toString() {
  return 'ShoppingItem(id: $id, name: $name, quantity: $quantity, note: $note, category: $category, status: $status, updatedAt: $updatedAt, updatedBy: $updatedBy, order: $order, createdAt: $createdAt, boughtAt: $boughtAt)';
}


}

/// @nodoc
abstract mixin class $ShoppingItemCopyWith<$Res>  {
  factory $ShoppingItemCopyWith(ShoppingItem value, $Res Function(ShoppingItem) _then) = _$ShoppingItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, int quantity, String? note, String? category, String status,@TimestampConverter() DateTime? updatedAt, String updatedBy, int order,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? boughtAt
});




}
/// @nodoc
class _$ShoppingItemCopyWithImpl<$Res>
    implements $ShoppingItemCopyWith<$Res> {
  _$ShoppingItemCopyWithImpl(this._self, this._then);

  final ShoppingItem _self;
  final $Res Function(ShoppingItem) _then;

/// Create a copy of ShoppingItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? quantity = null,Object? note = freezed,Object? category = freezed,Object? status = null,Object? updatedAt = freezed,Object? updatedBy = null,Object? order = null,Object? createdAt = freezed,Object? boughtAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,boughtAt: freezed == boughtAt ? _self.boughtAt : boughtAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShoppingItem].
extension ShoppingItemPatterns on ShoppingItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShoppingItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShoppingItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShoppingItem value)  $default,){
final _that = this;
switch (_that) {
case _ShoppingItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShoppingItem value)?  $default,){
final _that = this;
switch (_that) {
case _ShoppingItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int quantity,  String? note,  String? category,  String status, @TimestampConverter()  DateTime? updatedAt,  String updatedBy,  int order, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? boughtAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShoppingItem() when $default != null:
return $default(_that.id,_that.name,_that.quantity,_that.note,_that.category,_that.status,_that.updatedAt,_that.updatedBy,_that.order,_that.createdAt,_that.boughtAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int quantity,  String? note,  String? category,  String status, @TimestampConverter()  DateTime? updatedAt,  String updatedBy,  int order, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? boughtAt)  $default,) {final _that = this;
switch (_that) {
case _ShoppingItem():
return $default(_that.id,_that.name,_that.quantity,_that.note,_that.category,_that.status,_that.updatedAt,_that.updatedBy,_that.order,_that.createdAt,_that.boughtAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int quantity,  String? note,  String? category,  String status, @TimestampConverter()  DateTime? updatedAt,  String updatedBy,  int order, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? boughtAt)?  $default,) {final _that = this;
switch (_that) {
case _ShoppingItem() when $default != null:
return $default(_that.id,_that.name,_that.quantity,_that.note,_that.category,_that.status,_that.updatedAt,_that.updatedBy,_that.order,_that.createdAt,_that.boughtAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShoppingItem implements ShoppingItem {
  const _ShoppingItem({required this.id, required this.name, this.quantity = 1, this.note, this.category, this.status = 'active', @TimestampConverter() this.updatedAt, required this.updatedBy, this.order = 0, @TimestampConverter() this.createdAt, @TimestampConverter() this.boughtAt});
  factory _ShoppingItem.fromJson(Map<String, dynamic> json) => _$ShoppingItemFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  int quantity;
@override final  String? note;
@override final  String? category;
@override@JsonKey() final  String status;
// 'active' | 'bought'
@override@TimestampConverter() final  DateTime? updatedAt;
@override final  String updatedBy;
@override@JsonKey() final  int order;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? boughtAt;

/// Create a copy of ShoppingItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShoppingItemCopyWith<_ShoppingItem> get copyWith => __$ShoppingItemCopyWithImpl<_ShoppingItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShoppingItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShoppingItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.order, order) || other.order == order)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.boughtAt, boughtAt) || other.boughtAt == boughtAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,quantity,note,category,status,updatedAt,updatedBy,order,createdAt,boughtAt);

@override
String toString() {
  return 'ShoppingItem(id: $id, name: $name, quantity: $quantity, note: $note, category: $category, status: $status, updatedAt: $updatedAt, updatedBy: $updatedBy, order: $order, createdAt: $createdAt, boughtAt: $boughtAt)';
}


}

/// @nodoc
abstract mixin class _$ShoppingItemCopyWith<$Res> implements $ShoppingItemCopyWith<$Res> {
  factory _$ShoppingItemCopyWith(_ShoppingItem value, $Res Function(_ShoppingItem) _then) = __$ShoppingItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int quantity, String? note, String? category, String status,@TimestampConverter() DateTime? updatedAt, String updatedBy, int order,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? boughtAt
});




}
/// @nodoc
class __$ShoppingItemCopyWithImpl<$Res>
    implements _$ShoppingItemCopyWith<$Res> {
  __$ShoppingItemCopyWithImpl(this._self, this._then);

  final _ShoppingItem _self;
  final $Res Function(_ShoppingItem) _then;

/// Create a copy of ShoppingItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? quantity = null,Object? note = freezed,Object? category = freezed,Object? status = null,Object? updatedAt = freezed,Object? updatedBy = null,Object? order = null,Object? createdAt = freezed,Object? boughtAt = freezed,}) {
  return _then(_ShoppingItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,boughtAt: freezed == boughtAt ? _self.boughtAt : boughtAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
