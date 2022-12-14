import 'package:get_it/get_it.dart';

import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/domain/databases/context_models/user_settings.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/infrastructure/iconfig_manager.dart';
import 'package:synctest/infrastructure/idata_repository.dart';

class ConfigManager implements IConfigManager {
  GetIt getIt = GetIt.instance;
  late IDataRepository repository;

  ConfigManager() {
    repository = getIt.get<IDataRepository>();
  }

  @override
  Future<bool> addNewConfig(UserSettings settings) async {
    var existingSetting = await repository.getSettings();
    if (existingSetting == null) {
      await repository.addNewConfig(settings);
      return true;
    }

    await removeExistingData();

    var state = await repository.addNewConfig(settings);

    return state;
  }

  @override
  Future<bool> importConfiguration(
      UserSettings settings, List<AuthConnection> connections) async {
    var existingSetting = await repository.getSettings();
    if (existingSetting == null) {
      await repository.addNewConfig(settings);
      return true;
    }

    await removeExistingData();

    var state = await repository.addNewConfig(settings);

    for (var connection in connections) {
      await repository.addConnection(connection);
    }

    return state;
  }

  @override
  Future<bool> isConfigured() async {
    var existingSetting = await repository.getSettings();
    if (existingSetting == null) {
      return false;
    }

    return true;
  }

  Future<void> removeExistingData() async {
    List<ConnectionAttempt> connectionAttempts = [];
    var authConnections = await repository.getAllConnections();

    for (var element in authConnections) {
      var boundAttempts =
          await repository.getConnectionAttemptsByAuthId(element.id);
      connectionAttempts.addAll(boundAttempts);
      await repository.removeConnection(element.id);
    }

    for (var element in connectionAttempts) {
      await repository.removeConnectionAttempt(element.id);
    }
  }
}
