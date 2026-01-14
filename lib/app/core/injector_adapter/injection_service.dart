abstract class InjectionService {
  void registerFactory<T extends Object>(T instance);
  void registerLazySingleton<T extends Object>(T instance);
  T get<T extends Object>();
}
