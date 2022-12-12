import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/user_settings.dart';

abstract class IConfigManager {
  Future<bool> isConfigured();
  Future<bool> importConfiguration(
      UserSettings settings, List<AuthConnection> connections);
  Future<bool> addNewConfig(UserSettings settings);
}
