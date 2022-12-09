import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

//There is also a shortcut (if you don't like it just ignore it):
GetIt getIt = GetIt.I;

void registerDependency() {}

void registerFactory<T>(FactoryFunc<T> func) {
  getIt.registerFactory(() => func);
}

void registerSingleton<T>(FactoryFunc<T> instance) {
  getIt.registerSingleton(instance);
}

void registerLazySingleton<T>(FactoryFunc<T> func) {
  getIt.registerLazySingleton(() => func);
}
