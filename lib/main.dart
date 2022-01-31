import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_tool/Home/home.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_form.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/audio_test.dart';
//import 'package:kids_learning_tool/Quiz/DragDrop/audioTest.dart';
//import 'package:kids_learning_tool/Quiz/DragDrop/drag.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/dragForm.dart';
//import 'package:kids_learning_tool/Quiz/Matching/preview.dart';
//import 'package:kids_learning_tool/Quiz/Matching/question.dart';
import 'package:kids_learning_tool/Quiz/quiz.dart';
import 'package:libwinmedia/libwinmedia.dart';

import 'Quiz/Matching/matching.dart';
//import 'package:kplayer/kplayer.dart';

Future<void> main() async {
  const projectId = 'crested-plexus-330007';
  LWM.initialize();
  //AudioPlayer.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  
  Firestore.initialize(projectId);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/noun': (context) => Noun(),
      '/nounForm': (context) => NounForm(),
      '/quiz': (context) => Quiz(),
      '/matching': (context) => Matching(),
      '/drag': (context) => MyApp(), //DragForm(),
      //'/preview': (context) => Preview(question);
    },
  ));
}
