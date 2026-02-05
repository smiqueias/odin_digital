abstract interface class DependencyManager {
  T singleton<T extends Object>(T instance);
  void factory<T extends Object>(T Function() factoryBuilder);
  Future<void> reset({bool dispose = true});
  T get<T extends Object>();
}
