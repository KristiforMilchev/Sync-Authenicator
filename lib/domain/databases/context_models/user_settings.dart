import 'package:hive/hive.dart';
part '../adaptors/user_settings.g.dart';

@HiveType(typeId: 3)
class UserSettings extends HiveObject {
  @HiveField(0)
  String address;
  @HiveField(1)
  String pk;
  @HiveField(2)
  DateTime dateTime;

  UserSettings(this.address, this.pk, this.dateTime);

  UserSettings.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        pk = json['pk'],
        dateTime = json['dateTime'];

  Map<String, dynamic> toJson() => {
        'address': address,
        'pk': pk,
        'dateTime': dateTime.toString(),
      };
}
