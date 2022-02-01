import 'package:hive/hive.dart';

import 'package:kids_learning_tool/Model/noun_list.dart';

class Boxes {
  static Box<NounItem> getTransactions() =>
      Hive.box<NounItem>('nouns');
}