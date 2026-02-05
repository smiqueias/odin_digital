import 'package:supabase_flutter/supabase_flutter.dart';

typedef QueryResult = List<Map<String, dynamic>>;

abstract interface class BaaSDataSource {
  Future<bool> insert({
    required String tableName,
    required Object values,
  });

  Future<QueryResult> select({
    required String tableName,
    required String columns,
  });
}

final class BaaSDataSourceImpl implements BaaSDataSource {
  @override
  Future<bool> insert({
    required String tableName,
    required Object values,
  }) async {
    try {
      await Supabase.instance.client.from(tableName).insert(values);
      return true;
    } catch (error, stacktrace) {
      return false;
    }
  }

  @override
  Future<QueryResult> select({
    required String tableName,
    required String columns,
  }) async {
    try {
      final queryResult = await Supabase.instance.client.from(tableName).select(columns);
      return queryResult;
    } catch (error, stacktrace) {
      return [];
    }
  }
}
