//https://www.youtube.com/watch?v=pwkDaGbYuu8&ab_channel=TechiePraveen
import 'dart:io';
import 'dart:math';

//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_tool/Quiz/DragDrop/item_model.dart';
//import 'package:kids_learning_tool/Quiz/DragDrop/question.dart';

class Drag extends StatefulWidget {
  final List<ItemModel> items1;
  final List<ItemModel> items2;
  final String question;
  const Drag(this.items1, this.items2, this.question);
  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
  //List<ItemModel> items = [];
  //List<ItemModel> items2 = [];

  int score = 0;
  //int total = 0;
  bool gameOver = false;
  AudioPlayer audioPlayer = AudioPlayer();
  late ConfettiController _confettiController,
      _smallConfettiController,
      _confettiRightController,
      _confettiLeftController;

  //bool _isPlaying = false;
  bool playConfetti = false;
  //PlayerState? _state;

  //final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    initDrag();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _confettiController.dispose();
    _smallConfettiController.dispose();
    super.dispose();
  }

  initDrag() {
    score = 0;
    gameOver = false;
    audioPlayer.setAsset('assets/Audios/win.wav');

    ///_audioPlayer.
    _confettiController = ConfettiController();
    _smallConfettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _confettiRightController =
        ConfettiController(duration: const Duration(seconds: 1));
    _confettiLeftController =
        ConfettiController(duration: const Duration(seconds: 1));

    widget.items1.shuffle();
    widget.items2.shuffle();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    if (score == widget.items1.length + score) {
      gameOver = true;
      _confettiController.play();
      //_audioPlayer.play(loopmode: LoopMode.one);
    }
    return Scaffold(
      //backgroundColor: Colors.amber[300],
      appBar: AppBar(
          centerTitle: true,
          title: Text.rich(TextSpan(children: [
            const TextSpan(
                text: 'Score: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            TextSpan(
                text: '$score / ${widget.items1.length + score}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
          ]))),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                'Q. ' + widget.question,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              if (gameOver == false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //CENTER LEFT -- Emit right
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ConfettiWidget(
                        confettiController: _confettiLeftController,
                        blastDirection: 0, // radial value - RIGHT
                        emissionFrequency: 0.09,
                        minimumSize: const Size(8,
                            8), // set the minimum potential size for the confetti (width, height)
                        maximumSize: const Size(18,
                            18), // set the maximum potential size for the confetti (width, height)
                        numberOfParticles: 7,
                        gravity: 0.1,
                      ),
                    ),
                    Column(
                      children: widget.items1.map((item) {
                        return Container(
                          margin:
                              const EdgeInsets.fromLTRB(100.0, 10.0, 25.0, 8.0),
                          child: Draggable<ItemModel>(
                            data: item,
                            childWhenDragging: SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.file(
                                  File(item.value.split(' ').first),
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                  //colorBlendMode: BlendMode.darken,
                                )),
                            feedback: SizedBox(
                                height: 100,
                                width: 150,
                                child: Image.file(
                                  File(item.value.split(' ').first),
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                )),
                            child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Image.file(
                                  File(item.value.split(' ').first),
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                )),
                          ),
                        );
                      }).toList(),
                    ),
                    //const Spacer(),
                    //const Text('hi'),
                    // playConfetti
                    //     ? _confetti(_smallConfettiController, false)
                    //     : const SizedBox(width: 0),
                    Align(
                      alignment: Alignment.center,
                      child: ConfettiWidget(
                        confettiController: _smallConfettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        // don't specify a direction, blast randomly
                        shouldLoop:
                            false, // start again as soon as the animation is finished
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink,
                          Colors.orange,
                          Colors.purple
                        ], // manually specify the colors to be used
                        createParticlePath:
                            drawStar, // define a custom shape/path.
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: widget.items2.map((item) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(25, 10, 100, 8.0),
                          child: DragTarget<ItemModel>(
                            onAccept: (receivedItem) {
                              if (item.value ==
                                  receivedItem.value.split(' ').last) {
                                //_audioPlayer.stop();
                                //_audioPlayer.play();
                                setState(() {
                                  playConfetti = true;
                                  _smallConfettiController.play();
                                  _confettiRightController.play();
                                  _confettiLeftController.play();
                                  audioPlayer.seek(Duration.zero);
                                  // _audioPlayer.setAsset('assets/Audios/win.wav',
                                  //     preload: true);
                                  widget.items1.remove(receivedItem);
                                  widget.items2.remove(item);
                                  //dispose();
                                  score += 1;
                                  item.accepting = false;
                                  //_audioPlayer.dispose();
                                });

                                audioPlayer.play();
                                // Future.delayed(
                                //     const Duration(milliseconds: 700), () {
                                //   setState(() {
                                //     playConfetti = false;
                                //   });
                                // });
                                //_confetti(false);
                                //_audioPlayer.stop();
                              } else {
                                setState(() {
                                  //score -= 1;
                                  item.accepting = false;
                                  playConfetti = false;
                                });
                              }
                            },
                            onLeave: (receivedItem) {
                              setState(() {
                                item.accepting = false;
                                playConfetti = false;
                              });
                            },
                            onWillAccept: (receivedItem) {
                              setState(() {
                                item.accepting = true;
                                playConfetti = false;
                              });
                              return true;
                            },
                            builder: (context, acceptedItem, rejectedItem) =>
                                Container(
                              color: item.accepting ? Colors.red : Colors.blue,
                              height: 70,
                              width: 150,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8.0),
                              child: Text(item.value,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    //CENTER RIGHT -- Emit left
                    Align(
                      alignment: Alignment.centerRight,
                      child: ConfettiWidget(
                        confettiController: _confettiRightController,
                        blastDirection: pi, // radial value - LEFT
                        particleDrag: 0.05, // apply drag to the confetti
                        emissionFrequency: 0.09, // how often it should emit
                        numberOfParticles: 7, // number of particles to emit
                        gravity: 0.1, // gravity - or fall speed
                        shouldLoop: false,
                        colors: const [
                          Colors.green,
                          Colors.blue,
                          Colors.pink
                        ], // manually specify the colors to be used
                        // strokeWidth: 1,
                        // strokeColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              if (gameOver)
                Column(
                  children: <Widget>[
                    const Text('Quiz Complete !!!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    const SizedBox(height: 30),
                    //_confetti(_confettiController, true),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                          height: 250,
                          width: 300,
                          child: Image.file(
                            File(
                                'D:/Sadi/FlutterProjects/Flutter_Desktop_Application-main/assets/Rewards/congrats2.gif'),
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          )),
                    ),
                    // Center(
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         minimumSize: const Size(100, 60), elevation: 3),
                    //     child: const Text(
                    //       'Try Again',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     onPressed: () {
                    //       initDrag();
                    //       setState(() {});
                    //     },
                    //   ),
                    // )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _confetti(ConfettiController confettiController, bool loop) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            // don't specify a direction, blast randomly
            shouldLoop:
                loop, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ),
        //CENTER RIGHT -- Emit left
        Align(
          alignment: Alignment.centerRight,
          child: ConfettiWidget(
            confettiController: _confettiRightController,
            blastDirection: pi, // radial value - LEFT
            particleDrag: 0.05, // apply drag to the confetti
            emissionFrequency: 0.05, // how often it should emit
            numberOfParticles: 20, // number of particles to emit
            gravity: 0.05, // gravity - or fall speed
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink
            ], // manually specify the colors to be used
            // strokeWidth: 1,
            // strokeColor: Colors.white,
          ),
        ),
      ],
    ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Matching Game",
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<ItemModel> items = [];
//   List<ItemModel> items2 = [];

//   int score = 0;
//   bool gameOver = false;

//   @override
//   void initState() {
//     super.initState();
//     initGame();
//   }

//   initGame() {
//     gameOver = false;
//     score = 0;
//     items = [
//       ItemModel(icon: FontAwesomeIcons.coffee, name: "Coffee", value: "Coffee"),
//       ItemModel(icon: FontAwesomeIcons.dog, name: "dog", value: "dog"),
//       ItemModel(icon: FontAwesomeIcons.cat, name: "Cat", value: "Cat"),
//       ItemModel(
//           icon: FontAwesomeIcons.birthdayCake, name: "Cake", value: "Cake"),
//       ItemModel(icon: FontAwesomeIcons.bus, name: "bus", value: "bus"),
//     ];
//     items2 = List<ItemModel>.from(items);
//     items.shuffle();
//     items2.shuffle();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) gameOver = true;
//     return Scaffold(
//       //backgroundColor: Colors.amber,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Matching Game'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Text.rich(TextSpan(children: [
//               TextSpan(text: "Score: "),
//               TextSpan(
//                   text: "$score",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30.0,
//                   ))
//             ])),
//             if (!gameOver)
//               Row(
//                 children: <Widget>[
//                   Column(
//                       children: items.map((item) {
//                     return Container(
//                       margin: const EdgeInsets.all(8.0),
//                       child: Draggable<ItemModel>(
//                         data: item,
//                         childWhenDragging: Icon(
//                           item.icon,
//                           color: Colors.grey,
//                           size: 50.0,
//                         ),
//                         feedback: Icon(
//                           item.icon,
//                           color: Colors.black,
//                           size: 50,
//                         ),
//                         child: Icon(
//                           item.icon,
//                           color: Colors.black,
//                           size: 50,
//                         ),
//                       ),
//                     );
//                   }).toList()),
//                   Spacer(),
//                   Column(
//                       children: items2.map((item) {
//                     return DragTarget<ItemModel>(
//                       onAccept: (receivedItem) {
//                         if (item.value == receivedItem.value) {
//                           setState(() {
//                             items.remove(receivedItem);
//                             items2.remove(item);
//                             score += 10;
//                             item.accepting = false;
//                           });
//                         } else {
//                           setState(() {
//                             score -= 5;
//                             item.accepting = false;
//                           });
//                         }
//                       },
//                       onLeave: (receivedItem) {
//                         setState(() {
//                           item.accepting = false;
//                         });
//                       },
//                       onWillAccept: (receivedItem) {
//                         setState(() {
//                           item.accepting = true;
//                         });
//                         return true;
//                       },
//                       builder: (context, acceptedItems, rejectedItem) =>
//                           Container(
//                         color: item.accepting ? Colors.red : Colors.teal,
//                         height: 50,
//                         width: 100,
//                         alignment: Alignment.center,
//                         margin: const EdgeInsets.all(8.0),
//                         child: Text(
//                           item.name,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0),
//                         ),
//                       ),
//                     );
//                   }).toList()),
//                 ],
//               ),
//             if (gameOver)
//               Text(
//                 "GameOver",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24.0,
//                 ),
//               ),
//             if (gameOver)
//               Center(
//                 child: RaisedButton(
//                   textColor: Colors.white,
//                   color: Colors.pink,
//                   child: Text("New Game"),
//                   onPressed: () {
//                     initGame();
//                     setState(() {});
//                   },
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ItemModel {
//   final String name;
//   final String value;
//   final IconData icon;
//   bool accepting;

//   ItemModel(
//       {required this.name,
//       required this.value,
//       required this.icon,
//       this.accepting = false});
// }

//async
//_audioPlayer.seek(Duration.zero);
//receivedItem.icon = FontAwesomeIcons.check;
//item.name = 'Correct!';
//item.value = '#x';
// try {
//   assetsAudioPlayer.open(
//     Audio("assets/Audios/win.wav"),
//     autoStart: true,
//   );
// } catch (e) {
//   print(e);
// }
//_audioPlayer.setAsset('assets/Audios/win.wav');
//_isPlaying = true;
// if (!_isPlaying) {
//   _audioPlayer.stop();
//   _isPlaying = true;
//   print(_state?.processingState !=
//       ProcessingState.ready);
// }
// if (_isPlaying) {
//   print(_state?.processingState !=
//       ProcessingState.ready);
//   _audioPlayer.play();
//   _isPlaying = false;
// }
// Future.delayed(
//     const Duration(microseconds: 500));
//_audioPlayer.stop();
// }
// try {
//   await _audioPlayer.stop();
// } catch (e) {
//   throw Exception(e);
// }
// print(_state?.processingState !=
//     ProcessingState.ready);
//_audioPlayer.stop();
