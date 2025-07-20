import 'package:get_it/get_it.dart';
import 'package:gtb_core/contracts/dependency_manager.dart';

final class GtbDependencyManager implements DependencyManager {
  GtbDependencyManager._();

  static final GtbDependencyManager _instance = GtbDependencyManager._();

  static GtbDependencyManager get instance => _instance;

  GetIt get getIt => GetIt.asNewInstance();

  @override
  void factory<T extends Object>(T Function() factoryBuilder) {
    getIt.registerFactory(factoryBuilder);
  }

  @override
  T singleton<T extends Object>(T instance) {
    return getIt.registerSingleton(instance);
  }

  @override
  Future<void> reset({bool dispose = true}) async {
    await getIt.reset(dispose: dispose);
  }

  @override
  T get<T extends Object>() => getIt.get<T>();
}
