import 'package:flutter/foundation.dart';
import 'package:synctest/domain/databases/context_models/auth_connection.dart';
import 'package:synctest/domain/databases/context_models/user_settings.dart';

class ImportSettings {
  late final UserSettings userSettings;
  late final List<AuthConnection> connections;

  ImportSettings(this.userSettings, this.connections);

  ImportSettings.fromJson(Map<String, dynamic> json)
      : userSettings = json['userSettings'],
        connections = json['connections'];

  Map<String, dynamic> toJson() => {
        'userSettings': userSettings,
        'connections': connections,
      };
}
