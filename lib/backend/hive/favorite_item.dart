import 'package:hive/hive.dart';

//flutter packages pub run build_runner build --delete-conflicting-outputs

part 'favorite_item.g.dart';


@HiveType(typeId: 0)
class FavoriteItem {
  @HiveField(0)
  String? cityName;

  @HiveField(1)
  String? timeZone;

  @HiveField(2)
  String? bg;

  @HiveField(3)
  String? icon;

  @HiveField(4)
  int? temp;

  FavoriteItem({
    this.cityName,
    this.bg,
    this.icon,
    this.temp,
    this.timeZone,
  });
}
