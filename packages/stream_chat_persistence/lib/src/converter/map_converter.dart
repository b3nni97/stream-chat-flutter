import 'dart:convert';

import 'package:drift/drift.dart';

/// Maps a [Map] of type [String], [T] into a [String] understood
/// by the sqlite backend.
class MapConverter<T> extends TypeConverter<Map<String, T>, String> {
  @override
  Map<String, T>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Map<String, T>.from(jsonDecode(fromDb) ?? {});
  }

  @override
  String? mapToSql(Map<String, T>? value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value);
  }

  @override
  Map<String, T> fromSql(String fromDb) {
    // TODO: implement fromSql
    throw UnimplementedError();
  }

  @override
  String toSql(Map<String, T> value) {
    // TODO: implement toSql
    throw UnimplementedError();
  }
}
