// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  uid: json['uid'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
};
