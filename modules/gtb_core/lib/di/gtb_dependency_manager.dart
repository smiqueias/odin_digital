import 'package:get_it/get_it.dart';
import 'package:gtb_core/contracts/dependency_manager.dart';

final class GtbDependencyManager implements DependencyManager {
  GtbDependencyManager._();

  static final GtbDependencyManager _instance = GtbDependencyManager._();

  static GtbDependencyManager get instance => _instance;

  GetIt get _getIt => GetIt.asNewInstance();

  @override
  void factory<T extends Object>(T Function() factoryBuilder) {
    _getIt.registerFactory(factoryBuilder);
  }

  @override
  T singleton<T extends Object>(T instance) {
    return _getIt.registerSingleton(instance);
  }

  @override
  Future<void> reset({bool dispose = true}) async {
    await _getIt.reset(dispose: dispose);
  }

  @override
  T get<T extends Object>() => _getIt.get<T>();
}
