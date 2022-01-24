import 'package:flutter/material.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_tool/Home/home.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_form.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/audioTest.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/drag.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/dragForm.dart';
//import 'package:kids_learning_tool/Quiz/Matching/preview.dart';
//import 'package:kids_learning_tool/Quiz/Matching/question.dart';
import 'package:kids_learning_tool/Quiz/quiz.dart';
import 'package:libwinmedia/libwinmedia.dart';

import 'Quiz/Matching/matching.dart';
//import 'package:kplayer/kplayer.dart';

void main() {
  LWM.initialize();
  //AudioPlayer.setMockInitialValues({});

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/noun': (context) => Noun(),
      '/nounForm': (context) => NounForm(),
      '/quiz': (context) => Quiz(),
      '/matching': (context) => Matching(),
      '/drag': (context) => DragForm(),
      //'/preview': (context) => Preview(question);
    },
  ));
}
