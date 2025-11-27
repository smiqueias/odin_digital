import 'package:gtb_core/contracts/baas_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class BaaSClientImpl implements BaaSClient {
  BaaSClientImpl._();

  static final BaaSClientImpl _instance = BaaSClientImpl._();

  static BaaSClientImpl get instance => _instance;

  @override
  Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }
}
