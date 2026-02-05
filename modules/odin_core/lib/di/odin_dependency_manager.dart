import 'package:get_it/get_it.dart';
import 'package:odin_core/contracts/dependency_manager.dart';

final class OdinDependencyManager implements DependencyManager {
  OdinDependencyManager._();

  static final OdinDependencyManager _instance = OdinDependencyManager._();

  static OdinDependencyManager get instance => _instance;

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
