abstract interface class BaaSClient {
  Future<void> initialize({
    required String url,
    required String anonKey,
  });
}
