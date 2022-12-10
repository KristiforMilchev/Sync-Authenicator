import 'package:hive_flutter/hive_flutter.dart';
import 'package:synctest/domain/databases/context_models/connection_attempt.dart';
import 'context_models/auth_connection.dart';

class DatabaseContext<T> {
  late Box<T> box;

  DatabaseContext();

  Future<Box<T>> create() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter(AuthConnectionAdapter());
    if (!Hive.isAdapterRegistered(2))
      Hive.registerAdapter(ConnectionAttemptAdapter());

    box = await Hive.openBox<T>("SyncAuthDb");

    return box;
  }
}
