import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:synctest/application/services/config_manager.dart';
import 'package:synctest/application/services/data_repository.dart';
import 'package:synctest/domain/databases/context_models/user_settings.dart';
import 'package:synctest/domain/databases/database_context.dart';
import 'package:synctest/infrastructure/iconfig_manager.dart';
import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';

import '../core/test_data.dart';

void main() {
  var getIt = GetIt.instance;

  getIt.registerSingleton<IDatabaseContext>(DatabaseContext());
  getIt.registerSingleton<IDataRepository>(DataRepository("sync-auth-debug"));
  getIt.registerSingleton<IConfigManager>(ConfigManager());

  IConfigManager configManager = getIt.get<IConfigManager>();
  group('ConfigStateHandlerTest -', () {
    test("ImportNewConfig", () async {
      var config = await configManager.addNewConfig(
          UserSettings("new", Encrypted(Uint8List(2)).base64, DateTime.now()));

      expect(config, true, reason: "Device create new config failed");
    });

    test("ImportDatabaseConfig", () async {
      var state = await configManager.importConfiguration(
          UserSettings(
              "imported", Encrypted(Uint8List(2)).base64, DateTime.now()),
          TestsData().connections);

      expect(state, true, reason: "Importing existing account failed");
    });

    test("DeviceConfigured", () async {
      var state = await configManager.isConfigured();

      expect(state, true, reason: "Device config should be true after created");
    });
  });
}
