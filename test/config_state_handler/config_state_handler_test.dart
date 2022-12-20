import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:synctest/domain/databases/context_models/user_settings.dart';
import 'package:synctest/infrastructure/iconfig_manager.dart';

import '../core/test_data.dart';

void main() {
  TestsData testData = TestsData();

  IConfigManager configManager = testData.getIt.get<IConfigManager>();
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
          testData.connections);

      expect(state, true, reason: "Importing existing account failed");
    });

    test("DeviceConfigured", () async {
      var state = await configManager.isConfigured();

      expect(state, true, reason: "Device config should be true after created");
    });
  });
}
