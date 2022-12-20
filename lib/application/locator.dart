import 'package:get_it/get_it.dart';
import 'package:synctest/application/services/authentication.dart';
import 'package:synctest/application/services/blockchain_provider.dart';
import 'package:synctest/application/services/config_manager.dart';
import 'package:synctest/application/services/data_repository.dart';
import 'package:synctest/application/services/http_provider.dart';
import 'package:synctest/application/services/page_router_service.dart';
import 'package:synctest/domain/databases/database_context.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:synctest/infrastructure/iconfig_manager.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';
import 'package:synctest/infrastructure/ihttp_provider_service.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

//There is also a shortcut (if you don't like it just ignore it):
GetIt getIt = GetIt.I;

void registerDependency() {
  getIt.registerSingleton<IDatabaseContext>(DatabaseContext());
  getIt.registerSingleton<IDataRepository>(
      DataRepository("sync-auth-production"));
  getIt.registerSingleton<IConfigManager>(ConfigManager());
  getIt.registerSingleton<IBlokchainProvider>(Blockchainprovider());
  getIt.registerSingleton<IPageRouterService>(PageRouterService());
  getIt.registerSingleton<IHttpProviderService>(HttpProvider());
  getIt.registerSingleton<IAuthentication>(Authentication(HttpProvider(),
      DataRepository("sync-auth-production"), Blockchainprovider()));
}

void registerFactory<T>(FactoryFunc<T> func) {
  getIt.registerFactory(() => func);
}

void registerSingleton<T>(FactoryFunc<T> instance) {
  getIt.registerSingleton(instance);
}

void registerLazySingleton<T>(FactoryFunc<T> func) {
  getIt.registerLazySingleton(() => func);
}
