// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Group {

 String get id; String get name;@TimestampConverter() DateTime? get createdAt; String get createdBy; String get inviteCode; int get memberCount; List<String> get memberUids;
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupCopyWith<Group> get copyWith => _$GroupCopyWithImpl<Group>(this as Group, _$identity);

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Group&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other.memberUids, memberUids));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,createdBy,inviteCode,memberCount,const DeepCollectionEquality().hash(memberUids));

@override
String toString() {
  return 'Group(id: $id, name: $name, createdAt: $createdAt, createdBy: $createdBy, inviteCode: $inviteCode, memberCount: $memberCount, memberUids: $memberUids)';
}


}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res>  {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) = _$GroupCopyWithImpl;
@useResult
$Res call({
 String id, String name,@TimestampConverter() DateTime? createdAt, String createdBy, String inviteCode, int memberCount, List<String> memberUids
});




}
/// @nodoc
class _$GroupCopyWithImpl<$Res>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? createdAt = freezed,Object? createdBy = null,Object? inviteCode = null,Object? memberCount = null,Object? memberUids = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,memberUids: null == memberUids ? _self.memberUids : memberUids // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Group].
extension GroupPatterns on Group {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Group value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Group value)  $default,){
final _that = this;
switch (_that) {
case _Group():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Group value)?  $default,){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @TimestampConverter()  DateTime? createdAt,  String createdBy,  String inviteCode,  int memberCount,  List<String> memberUids)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Group() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.createdBy,_that.inviteCode,_that.memberCount,_that.memberUids);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @TimestampConverter()  DateTime? createdAt,  String createdBy,  String inviteCode,  int memberCount,  List<String> memberUids)  $default,) {final _that = this;
switch (_that) {
case _Group():
return $default(_that.id,_that.name,_that.createdAt,_that.createdBy,_that.inviteCode,_that.memberCount,_that.memberUids);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @TimestampConverter()  DateTime? createdAt,  String createdBy,  String inviteCode,  int memberCount,  List<String> memberUids)?  $default,) {final _that = this;
switch (_that) {
case _Group() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.createdBy,_that.inviteCode,_that.memberCount,_that.memberUids);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Group implements Group {
  const _Group({required this.id, required this.name, @TimestampConverter() this.createdAt, required this.createdBy, required this.inviteCode, this.memberCount = 0, final  List<String> memberUids = const []}): _memberUids = memberUids;
  factory _Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

@override final  String id;
@override final  String name;
@override@TimestampConverter() final  DateTime? createdAt;
@override final  String createdBy;
@override final  String inviteCode;
@override@JsonKey() final  int memberCount;
 final  List<String> _memberUids;
@override@JsonKey() List<String> get memberUids {
  if (_memberUids is EqualUnmodifiableListView) return _memberUids;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberUids);
}


/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupCopyWith<_Group> get copyWith => __$GroupCopyWithImpl<_Group>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Group&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other._memberUids, _memberUids));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,createdBy,inviteCode,memberCount,const DeepCollectionEquality().hash(_memberUids));

@override
String toString() {
  return 'Group(id: $id, name: $name, createdAt: $createdAt, createdBy: $createdBy, inviteCode: $inviteCode, memberCount: $memberCount, memberUids: $memberUids)';
}


}

/// @nodoc
abstract mixin class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) _then) = __$GroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@TimestampConverter() DateTime? createdAt, String createdBy, String inviteCode, int memberCount, List<String> memberUids
});




}
/// @nodoc
class __$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(this._self, this._then);

  final _Group _self;
  final $Res Function(_Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? createdAt = freezed,Object? createdBy = null,Object? inviteCode = null,Object? memberCount = null,Object? memberUids = null,}) {
  return _then(_Group(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,memberUids: null == memberUids ? _self._memberUids : memberUids // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$GroupMember {

 String get uid; String get role;// 'owner' | 'member'
@TimestampConverter() DateTime? get joinedAt; String? get displayName; String? get photoURL;
/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMemberCopyWith<GroupMember> get copyWith => _$GroupMemberCopyWithImpl<GroupMember>(this as GroupMember, _$identity);

  /// Serializes this GroupMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMember&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,role,joinedAt,displayName,photoURL);

@override
String toString() {
  return 'GroupMember(uid: $uid, role: $role, joinedAt: $joinedAt, displayName: $displayName, photoURL: $photoURL)';
}


}

/// @nodoc
abstract mixin class $GroupMemberCopyWith<$Res>  {
  factory $GroupMemberCopyWith(GroupMember value, $Res Function(GroupMember) _then) = _$GroupMemberCopyWithImpl;
@useResult
$Res call({
 String uid, String role,@TimestampConverter() DateTime? joinedAt, String? displayName, String? photoURL
});




}
/// @nodoc
class _$GroupMemberCopyWithImpl<$Res>
    implements $GroupMemberCopyWith<$Res> {
  _$GroupMemberCopyWithImpl(this._self, this._then);

  final GroupMember _self;
  final $Res Function(GroupMember) _then;

/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? role = null,Object? joinedAt = freezed,Object? displayName = freezed,Object? photoURL = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupMember].
extension GroupMemberPatterns on GroupMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupMember value)  $default,){
final _that = this;
switch (_that) {
case _GroupMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupMember value)?  $default,){
final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String role, @TimestampConverter()  DateTime? joinedAt,  String? displayName,  String? photoURL)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
return $default(_that.uid,_that.role,_that.joinedAt,_that.displayName,_that.photoURL);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String role, @TimestampConverter()  DateTime? joinedAt,  String? displayName,  String? photoURL)  $default,) {final _that = this;
switch (_that) {
case _GroupMember():
return $default(_that.uid,_that.role,_that.joinedAt,_that.displayName,_that.photoURL);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String role, @TimestampConverter()  DateTime? joinedAt,  String? displayName,  String? photoURL)?  $default,) {final _that = this;
switch (_that) {
case _GroupMember() when $default != null:
return $default(_that.uid,_that.role,_that.joinedAt,_that.displayName,_that.photoURL);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupMember implements GroupMember {
  const _GroupMember({required this.uid, required this.role, @TimestampConverter() this.joinedAt, this.displayName, this.photoURL});
  factory _GroupMember.fromJson(Map<String, dynamic> json) => _$GroupMemberFromJson(json);

@override final  String uid;
@override final  String role;
// 'owner' | 'member'
@override@TimestampConverter() final  DateTime? joinedAt;
@override final  String? displayName;
@override final  String? photoURL;

/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupMemberCopyWith<_GroupMember> get copyWith => __$GroupMemberCopyWithImpl<_GroupMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupMember&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoURL, photoURL) || other.photoURL == photoURL));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,role,joinedAt,displayName,photoURL);

@override
String toString() {
  return 'GroupMember(uid: $uid, role: $role, joinedAt: $joinedAt, displayName: $displayName, photoURL: $photoURL)';
}


}

/// @nodoc
abstract mixin class _$GroupMemberCopyWith<$Res> implements $GroupMemberCopyWith<$Res> {
  factory _$GroupMemberCopyWith(_GroupMember value, $Res Function(_GroupMember) _then) = __$GroupMemberCopyWithImpl;
@override @useResult
$Res call({
 String uid, String role,@TimestampConverter() DateTime? joinedAt, String? displayName, String? photoURL
});




}
/// @nodoc
class __$GroupMemberCopyWithImpl<$Res>
    implements _$GroupMemberCopyWith<$Res> {
  __$GroupMemberCopyWithImpl(this._self, this._then);

  final _GroupMember _self;
  final $Res Function(_GroupMember) _then;

/// Create a copy of GroupMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? role = null,Object? joinedAt = freezed,Object? displayName = freezed,Object? photoURL = freezed,}) {
  return _then(_GroupMember(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoURL: freezed == photoURL ? _self.photoURL : photoURL // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
