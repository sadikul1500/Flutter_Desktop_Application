import 'dart:io';

class DragQuestion {
  List<File> files;
  List<String> values;
  List<String> valuesRight;
  late List<String> valuesLeft;
  bool accepting;

  DragQuestion(this.files, this.values, this.valuesRight,
      {this.accepting = false}) {
    valuesLeft = newList();
  }

  List<String> newList() {
    for (int i = 0; i < values.length; i++) {
      valuesLeft.add(files[i].path + ' ' + values[i].trim());
    }
    return valuesLeft;
  }
}
