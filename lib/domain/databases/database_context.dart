// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:hive_flutter/hive_flutter.dart';

import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'package:synctest/infrastructure/idatabase_context.dart';
import 'context_models/auth_connection.dart';

class DatabaseContext implements IDatabaseContext {
  late Box _box;

  @override
  Future<Box> create() async {
    final Box box;

    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(AuthConnectionAdapter());
    if (!Hive.isAdapterRegistered(2))
      Hive.registerAdapter(ConnectionAttemptAdapter());

    if (!Hive.isBoxOpen("SyncAuthDb"))
      box = await Hive.openBox("SyncAuthDb");
    else
      box = Hive.box("SyncAuthDb");

    return box;
  }

  @override
  Box getBox() {
    // TODO: implement GetBox
    return _box;
  }
}
