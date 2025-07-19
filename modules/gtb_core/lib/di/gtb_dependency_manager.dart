import 'package:get_it/get_it.dart';
import 'package:gtb_core/contracts/dependency_manager.dart';

final class GtbDependencyManager implements DependencyManager {
  const GtbDependencyManager._();

  factory GtbDependencyManager.asNewInstance() => GtbDependencyManager._();

  GetIt get getIt => GetIt.I;

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
