import 'package:hive_flutter/hive_flutter.dart';
import 'package:objectbox/objectbox.dart';
part '../adaptors/connection_attempt.g.dart';

@HiveType(typeId: 2)
class ConnectionAttempt {
  @HiveField(0)
  int id;
  @HiveField(1)
  final int authConnectionId;
  @HiveField(2)
  final String message;
  @HiveField(3)
  final String signature;
  @HiveField(4)
  final DateTime date;

  ConnectionAttempt(
      this.authConnectionId, this.date, this.id, this.message, this.signature);
}
