import 'package:hive_flutter/hive_flutter.dart';

part '../adaptors/auth_connection.g.dart';

@HiveType(typeId: 1)
class AuthConnection extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String registerHash;
  @HiveField(4)
  final bool isEnabled;
  @HiveField(5)
  final DateTime createdAt;

  AuthConnection(this.id, this.createdAt, this.email, this.isEnabled,
      this.registerHash, this.url);

  @override
  String toString() {
    return '$url: $email';
  }
}
