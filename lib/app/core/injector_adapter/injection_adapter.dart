import 'package:get_it/get_it.dart';
import 'package:app_test_fiap/app/core/injector_adapter/injection_service.dart';

class InjectionAdapter implements InjectionService {
  const InjectionAdapter(this._getIt);

  final GetIt _getIt;

  @override
  void registerFactory<T extends Object>(T instance) {
    _getIt.registerFactory<T>(() => instance);
  }

  @override
  void registerLazySingleton<T extends Object>(T instance) {
    _getIt.registerLazySingleton<T>(() => instance);
  }

  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
