import 'package:get_it/get_it.dart';
import 'package:synctest/application/services/authentication.dart';
import 'package:synctest/application/services/blockchain_provider.dart';
import 'package:synctest/application/services/config_manager.dart';
import 'package:synctest/application/services/data_repository.dart';
import 'package:synctest/application/services/http_provider.dart';
import 'package:synctest/application/services/page_router_service.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/database_context.dart';
import 'package:synctest/domain/models/user_wallet.dart';
import 'package:synctest/infrastructure/iauthentication.dart';
import 'package:synctest/infrastructure/iblockchain_provider.dart';
import 'package:synctest/infrastructure/iconfig_manager.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';
import 'package:synctest/infrastructure/ihttp_provider_service.dart';
import 'package:synctest/infrastructure/ipage_router_service.dart';

class TestsData {
  GetIt getIt = GetIt.I;

  TestsData() {
    if (!getIt.isRegistered<IDatabaseContext>()) {
      getIt.registerSingleton<IDatabaseContext>(DatabaseContext());
    }
    if (!getIt.isRegistered<IDataRepository>()) {
      getIt.registerSingleton<IDataRepository>(
          DataRepository("sync-auth-debug"));
    }
    if (!getIt.isRegistered<IConfigManager>()) {
      getIt.registerSingleton<IConfigManager>(ConfigManager());
    }
    if (!getIt.isRegistered<IBlokchainProvider>()) {
      getIt.registerSingleton<IBlokchainProvider>(Blockchainprovider());
    }
    if (!getIt.isRegistered<IPageRouterService>()) {
      getIt.registerSingleton<IPageRouterService>(PageRouterService());
    }
    if (!getIt.isRegistered<IHttpProviderService>()) {
      getIt.registerSingleton<IHttpProviderService>(HttpProvider());
    }
    if (!getIt.isRegistered<IAuthentication>()) {
      getIt.registerSingleton<IAuthentication>(Authentication(HttpProvider(),
          DataRepository("sync-auth-debug"), Blockchainprovider()));
    }
  }

  String testWebsiteEndpoint = "https://sync-auth-core.azurewebsites.net";
  String privateKey =
      "7d978130132ba7455f25b21787ac707c758eae90577f13a9afce9b8c3911a4d9";
  String publicKey = "0x2fc3c3642d5A860f7E4CAA57CB84782AA6aeBAe8";
  String encryptionPassword = '+KbPeShVmYq3t6w9z2C&F)J@NcQfTjWn';

  String derivedBase64EncData =
      "7RT9h98FkRtW5f/OQsUAuP81UAyTS3lt/9Li/GK1ZgbHufJWu/xL0H1XoTBM+o0+ywVxQQoFbYVRktO+Nm9FmOPB5vE/SNG7FTeM9KQZohI=";

  String recordedTestSginature =
      "0x31a92c651ab813c8329d8dccc35ba5fa8635930894cc93983526c7e5069ee46a488500a6747f649c7b7eeb025aca1116c1cb6538772a5acdb95d689d6f5a57651c";

  String testMessage = "Test message";

  List<AuthConnection> connections = [
    AuthConnection(111, DateTime.now(), "jorge@contoso.com", true, "asdasdaa",
        "https://contoso.com"),
    AuthConnection(112, DateTime.now(), "soros@contoso.com", true, "asdasdaa",
        "https://bank.com"),
    AuthConnection(113, DateTime.now(), "peter@contoso.com", true, "asdasdaa",
        "https://account.com"),
  ];

  UserWallet initTestWallet() {
    return UserWallet(privateKey, publicKey);
  }
}
