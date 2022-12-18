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
  late final DateTime createdAt;

  AuthConnection(this.id, this.createdAt, this.email, this.isEnabled,
      this.registerHash, this.url);

  AuthConnection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        email = json['email'],
        registerHash = json['registerHash'],
        isEnabled = json['isEnabled'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'email': email,
        'registerHash': registerHash,
        'isEnabled': isEnabled,
        'createdAt': createdAt.toString()
      };

  @override
  String toString() {
    return '$url: $email';
  }
}
