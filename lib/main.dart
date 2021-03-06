//import 'package:firebase_core/firebase_core.dart';
//import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_tool/Home/home.dart';
import 'package:kids_learning_tool/Lessons/Color/color.dart';
import 'package:kids_learning_tool/Lessons/Maths/addition.dart';
import 'package:kids_learning_tool/Lessons/Maths/numeracy.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun.dart';
import 'package:kids_learning_tool/Lessons/Nouns/noun_form.dart';
import 'package:kids_learning_tool/Model/color_list.dart';
import 'package:kids_learning_tool/Model/noun_list.dart';
//import 'package:kids_learning_tool/Quiz/DragDrop/audio_test.dart';
//import 'package:kids_learning_tool/Quiz/DragDrop/audioTest.dart';
//import 'package:kids_learning_tool/Quiz/DragDrop/drag.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/drag_form.dart';
//import 'package:kids_learning_tool/Quiz/Matching/preview.dart';
//import 'package:kids_learning_tool/Quiz/Matching/question.dart';
import 'package:kids_learning_tool/Quiz/quiz.dart';
import 'package:libwinmedia/libwinmedia.dart';

import 'Quiz/Matching/matching.dart';
//import 'package:kplayer/kplayer.dart';

Future<void> main() async {
  LWM.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NounItemAdapter());
  Hive.registerAdapter(ColorItemAdapter());
  await Hive.openBox<NounItem>('nouns');
  await Hive.openBox<ColorItem>('colors');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/noun': (context) => Noun(),
      '/nounForm': (context) => NounForm(), //NounForm(),
      '/quiz': (context) => Quiz(),
      '/matching': (context) => Matching(),
      '/drag': (context) => DragForm(), //MyApp(), //DragForm(),
      '/numeracy': (context) => Number(),
      '/addition': (context) => Addition(),
      '/color': (context) => BasicColor(),
    },
  ));
}


//const projectId = 'crested-plexus-330007';
//Firestore.initialize(projectId);
//AudioPlayer.setMockInitialValues({});
//'/preview': (context) => Preview(question);
