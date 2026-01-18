import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    if (json is DateTime) {
      return json;
    }
    // Handle mock or string if needed
    if (json is String) {
      return DateTime.tryParse(json);
    }
    return null;
  }

  @override
  Object? toJson(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}
