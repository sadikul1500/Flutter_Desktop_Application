import 'package:hive_flutter/hive_flutter.dart';
part 'noun_list.g.dart';

@HiveType(typeId: 0)
class NounItem extends HiveObject {
  @HiveField(0)
  late String text;

  @HiveField(1)
  late String meaning;

  @HiveField(2)
  late String dir;

  @HiveField(3)
  late String audio;
}
