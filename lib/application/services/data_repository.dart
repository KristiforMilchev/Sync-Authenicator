import 'package:get_it/get_it.dart';

import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/domain/databases/context_models/user_settings.dart';

import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';

class DataRepository implements IDataRepository {
  GetIt getIt = GetIt.instance;
  late IDatabaseContext _context;
  late String _database;
  @override
  DataRepository(String database) {
    _context = getIt.get<IDatabaseContext>();
    _database = database;
  }

  @override
  Future<bool> addConnection(AuthConnection connection) async {
    var box = await _context.create(_database);
    var exists = box.values.whereType<AuthConnection?>().singleWhere(
      (element) => element?.id == connection.id,
      orElse: () {
        return;
      },
    );

    //Check if item of the same ID exists
    if (exists != null) {
      box.close();
      return false;
    }

    box.add(connection);

    box.close();
    return true;
  }

  @override
  Future<List<AuthConnection>> getAllConnections() async {
    var box = await _context.create(_database);
    var result = box.values.whereType<AuthConnection>()..toList();

    box.close();
    return result.toList();
  }

  @override
  Future<List<ConnectionAttempt>> getAllConnnectionAttempts() async {
    var box = await _context.create(_database);
    var result = box.values.whereType<ConnectionAttempt>()..toList();

    box.close();
    return result.toList();
  }

  @override
  Future<int> getLastAuthId() async {
    var connections = await getAllConnections();
    if (connections.isEmpty) {
      return 0;
    }

    return connections.last.id;
  }

  @override
  Future<int> getLasConnAttemptId() async {
    var connections = await getAllConnnectionAttempts();
    if (connections.isEmpty) {
      return 0;
    }

    return connections.last.id;
  }

  @override
  Future<AuthConnection?> getConnectionsById(int id) async {
    var box = await _context.create(_database);
    var result = box.values
        .whereType<AuthConnection>()
        .firstWhere((element) => element.id == id);

    box.close();
    return result;
  }

  @override
  Future<AuthConnection?> getConnectionsByEmailUrl(
      String email, String url) async {
    var box = await _context.create(_database);
    var result = box.values
        .whereType<AuthConnection>()
        .firstWhere((element) => element.url == url && element.email == email);

    box.close();
    return result;
  }

  @override
  Future<List<AuthConnection>> getEnabledConnections() async {
    var box = await _context.create(_database);
    var result = box.values
        .whereType<AuthConnection>()
        .where((element) => element.isEnabled)
        .toList();

    box.close();
    return result;
  }

  @override
  Future<bool> removeConnection(int id) async {
    var box = await _context.create(_database);

    var connection = box.values.whereType<AuthConnection?>().singleWhere(
      (element) => element?.id == id,
      orElse: () {
        return;
      },
    );

    if (connection == null) {
      box.close();
      return false;
    }

    await connection.delete();
    box.close();

    return true;
  }

  @override
  Future<List<ConnectionAttempt>> getConnectionAttemptsByAuthId(int id) async {
    var box = await _context.create(_database);

    if (box.values.isEmpty) {
      box.close();
      return [];
    }

    var result = box.values
        .whereType<ConnectionAttempt>()
        .where((element) => element.authConnectionId == id)
        .toList();

    box.close();
    return result.toList();
  }

  @override
  Future<bool> addConnectionAttempt(ConnectionAttempt connection) async {
    var box = await _context.create(_database);

    var exists = box.values.whereType<ConnectionAttempt?>().singleWhere(
      (element) => element?.id == connection.id,
      orElse: () {
        return;
      },
    );

    //Check if item of the same ID exists
    if (exists != null) {
      box.close();
      return false;
    }

    box.add(connection);
    box.close();
    return true;
  }

  @override
  Future<bool> removeConnectionAttempt(int id) async {
    var box = await _context.create(_database);
    var connection = box.values.whereType<ConnectionAttempt?>().singleWhere(
      (element) => element?.id == id,
      orElse: () {
        return;
      },
    );

    if (connection == null) {
      box.close();
      return false;
    }

    await connection.delete();

    box.close();
    return true;
  }

  @override
  Future<bool> addNewConfig(UserSettings settings) async {
    var box = await _context.create(_database);
    var setting = box.values.whereType<UserSettings?>();
    if (setting.isNotEmpty) {
      setting.single?.delete();
    }

    box.add(settings);
    return true;
  }

  @override
  Future<bool> removeUserConfig() async {
    var box = await _context.create(_database);
    var setting = box.values.whereType<UserSettings?>();
    if (setting.isEmpty) {
      box.close();
      return false;
    }

    await setting.single?.delete();

    box.close();
    return true;
  }

  @override
  Future<UserSettings?> getSettings() async {
    var box = await _context.create(_database);
    var setting = box.values.whereType<UserSettings?>();

    return setting.isEmpty ? null : setting.single;
  }

  @override
  Future<bool> updateAuthConnection(AuthConnection connection) async {
    var box = await _context.create(_database);
    var result = box.values
        .whereType<AuthConnection>()
        .firstWhere((element) => element.id == connection.id);
    result.createdAt = connection.createdAt;
    result.save();
    box.close();
    return true;
  }
}
