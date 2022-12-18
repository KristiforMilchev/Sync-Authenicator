import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/domain/databases/context_models/user_settings.dart';

abstract class IDataRepository<T> {
  Future<List<AuthConnection>> getAllConnections();
  Future<List<AuthConnection>> getEnabledConnections();
  Future<List<ConnectionAttempt>> getAllConnnectionAttempts();
  Future<int> getLastAuthId();
  Future<AuthConnection?> getConnectionsById(int id);
  Future<AuthConnection?> getConnectionsByEmailUrl(String email, String url);
  Future<bool> updateAuthConnection(AuthConnection connection);
  Future<int> getLasConnAttemptId();

  Future<List<ConnectionAttempt>> getConnectionAttemptsByAuthId(int id);
  Future<bool> addConnection(AuthConnection connection);
  Future<bool> removeConnection(int id);
  Future<bool> removeConnectionAttempt(int id);
  Future<bool> addConnectionAttempt(ConnectionAttempt connection);
  Future<bool> addNewConfig(UserSettings settings);
  Future<bool> removeUserConfig();
  Future<UserSettings?> getSettings();
}
