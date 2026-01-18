import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'converters/timestamp_converter.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
abstract class Group with _$Group {
  const factory Group({
    required String id,
    required String name,
    @TimestampConverter() DateTime? createdAt,
    required String createdBy,
    required String inviteCode,
    @Default(0) int memberCount,
    @Default([]) List<String> memberUids, // For querying my groups
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}

@freezed
abstract class GroupMember with _$GroupMember {
  const factory GroupMember({
    required String uid,
    required String role, // 'owner' | 'member'
    @TimestampConverter() DateTime? joinedAt,
    String? displayName,
    String? photoURL,
  }) = _GroupMember;

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);
}
