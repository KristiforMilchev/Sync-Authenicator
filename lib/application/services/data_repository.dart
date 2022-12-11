import 'package:get_it/get_it.dart';

import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';

import 'package:synctest/infrastructure/idata_repository.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';

class DataRepository implements IDataRepository {
  GetIt getIt = GetIt.instance;
  late IDatabaseContext _context;

  @override
  DataRepository() {
    _context = getIt.get<IDatabaseContext>();
  }

  @override
  Future<bool> addConnection(AuthConnection connection) async {
    var box = await _context.create();
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
    var box = await _context.create();
    var result = box.values.whereType<AuthConnection>()..toList();

    box.close();
    return result.toList();
  }

  @override
  Future<AuthConnection?> getConnectionsById(int id) async {
    var box = await _context.create();
    var result = box.values
        .whereType<AuthConnection>()
        .firstWhere((element) => element.id == id);

    box.close();
    return result;
  }

  @override
  Future<List<AuthConnection>> getEnabledConnections() async {
    var box = await _context.create();
    var result = box.values
        .whereType<AuthConnection>()
        .where((element) => element.isEnabled)
        .toList();

    box.close();
    return result;
  }

  @override
  Future<bool> removeConnection(int id) async {
    var box = await _context.create();

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
    var box = await _context.create();

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
    var box = await _context.create();

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
    var box = await _context.create();
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
}
