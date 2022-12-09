import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';

abstract class IDataRepository {
  void ensureCreated(String type);
  List<AuthConnection> getAllConnections();
  List<AuthConnection> getEnabledConnections();
  AuthConnection getConnectionsById(int id);
  List<ConnectionAttempt> getConnectionAttemptsByAuthId(int id);
  bool addConnection(AuthConnection connection);
  Future<bool> removeConnection(int id);
  bool addConnectionAttempt(ConnectionAttempt connection);
}
