// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Group _$GroupFromJson(Map<String, dynamic> json) => _Group(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  createdBy: json['createdBy'] as String,
  inviteCode: json['inviteCode'] as String,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
  memberUids:
      (json['memberUids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$GroupToJson(_Group instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'createdBy': instance.createdBy,
  'inviteCode': instance.inviteCode,
  'memberCount': instance.memberCount,
  'memberUids': instance.memberUids,
};

_GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) => _GroupMember(
  uid: json['uid'] as String,
  role: json['role'] as String,
  joinedAt: const TimestampConverter().fromJson(json['joinedAt']),
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
);

Map<String, dynamic> _$GroupMemberToJson(_GroupMember instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'role': instance.role,
      'joinedAt': const TimestampConverter().toJson(instance.joinedAt),
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
    };
