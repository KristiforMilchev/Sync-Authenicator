import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/domain/databases/database_context.dart';

import 'package:synctest/infrastructure/idata_repository.dart';

class DataRepository<T> implements IDataRepository {
  @override
  Future<bool> addConnection(AuthConnection connection) async {
    var context = DatabaseContext<AuthConnection>();
    var box = await context.create();
    box.add(connection);
    return true;
  }

  @override
  Future<List<AuthConnection>> getAllConnections() async {
    var context = DatabaseContext<AuthConnection>();
    var box = await context.create();

    return box.values.toList();
  }

  @override
  Future<AuthConnection?> getConnectionsById(int id) async {
    var context = DatabaseContext<AuthConnection>();
    var box = await context.create();

    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<AuthConnection>> getEnabledConnections() async {
    var context = DatabaseContext<AuthConnection>();
    var box = await context.create();

    return box.values.where((element) => element.isEnabled).toList();
  }

  @override
  Future<bool> removeConnection(int id) async {
    var context = DatabaseContext<AuthConnection>();
    var box = await context.create();
    var getById = await getConnectionsById(id);
    if (getById == null) return false;

    await box.delete(id);
    return true;
  }

  @override
  Future<List<ConnectionAttempt>> getConnectionAttemptsByAuthId(int id) async {
    var context = DatabaseContext<ConnectionAttempt>();
    var box = await context.create();

    return box.values
        .where((element) => element.authConnectionId == id)
        .toList();
  }

  @override
  Future<bool> addConnectionAttempt(ConnectionAttempt connection) async {
    var context = DatabaseContext<ConnectionAttempt>();
    var box = await context.create();

    box.add(connection);
    return true;
  }
}
