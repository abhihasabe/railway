import 'package:hive/hive.dart';

part 'lang_model.g.dart';

@HiveType(typeId: 1)
class Langs {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String? appLang;

  Langs({this.appLang});

  get getFullName => appLang;

  set setFullName(fullName) => appLang = fullName;

  @override
  String toString() {
    return 'UserEntity(id: $id, fullName: $appLang)';
  }
}