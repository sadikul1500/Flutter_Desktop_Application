import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer player;
  //late AssetsAudioPlayer audioPlayer;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setAsset('assets/Audios/win.wav');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  // playSound() async {
  //   AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  //   await audioPlayer.open(
  //     Audio(
  //       'assets/Audios/win.wav',
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  //async
                  // await player.setAsset('assets/Audios/win.wav');
                  if (player.playing) player.stop();
                  if (!player.playing) player.play();
                  //playSound();
                },
                child: const Text('Win'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
