import 'package:get_it/get_it.dart';
import 'package:synctest/application/services/data_repository.dart';

import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/domain/databases/database_context.dart';

import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';

//There is also a shortcut (if you don't like it just ignore it):
GetIt getIt = GetIt.I;

void registerDependency() {
  getIt.registerSingleton<IDatabaseContext>(DatabaseContext());
  getIt.registerSingleton<IDataRepository>(DataRepository());
}

DataRepository<AuthConnection> newMethod() => DataRepository<AuthConnection>();

void registerFactory<T>(FactoryFunc<T> func) {
  getIt.registerFactory(() => func);
}

void registerSingleton<T>(FactoryFunc<T> instance) {
  getIt.registerSingleton(instance);
}

void registerLazySingleton<T>(FactoryFunc<T> func) {
  getIt.registerLazySingleton(() => func);
}
