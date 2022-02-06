import 'dart:io';
import 'dart:convert';

class DragQuestion {
  late List<File> files;
  late List<String> values;
  late List<String> valuesRight;
  //late List<String> valuesLeft;
  late bool accepting;
  late String question;

  DragQuestion(this.files, this.values, this.valuesRight, this.question,
      {this.accepting = false}) {
    //valuesLeft = newList();
  }

  // List<String> newList() {
  //   for (int i = 0; i < values.length; i++) {
  //     valuesLeft.add(files[i].path + ' ' + values[i].trim());
  //   }
  //   return valuesLeft;
  // }

  DragQuestion.fromJson(Map<String, dynamic> json) {
    files = json['files'];
    values = json['values'];
    valuesRight = json['valuesRight'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['files'] = files;
    data['values'] = values;
    data['valuesRight'] = valuesRight;
    data['question'] = question;

    return data;
  }
}
