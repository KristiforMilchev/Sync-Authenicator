import 'package:encrypt/encrypt.dart';
import 'package:hive/hive.dart';
part '../adaptors/user_settings.g.dart';

@HiveType(typeId: 3)
class UserSettings extends HiveObject {
  @HiveField(0)
  String address;
  @HiveField(1)
  Encrypted pk;
  @HiveField(2)
  DateTime dateTime;

  UserSettings(this.address, this.pk, this.dateTime);
}
