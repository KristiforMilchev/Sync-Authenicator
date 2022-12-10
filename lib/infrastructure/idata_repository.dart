import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';

abstract class IDataRepository<T> {
  Future<List<AuthConnection>> getAllConnections();
  Future<List<AuthConnection>> getEnabledConnections();
  Future<AuthConnection?> getConnectionsById(int id);
  Future<List<ConnectionAttempt>> getConnectionAttemptsByAuthId(int id);
  Future<bool> addConnection(AuthConnection connection);
  Future<bool> removeConnection(int id);
  Future<bool> addConnectionAttempt(ConnectionAttempt connection);
}
