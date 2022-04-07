//https://pastebin.com/ZSgj4LU3
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_tool/Lessons/Color/addToDb.dart';
import 'package:kids_learning_tool/Model/color_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:kplayer/kplayer.dart';

class BasicColor extends StatefulWidget {
  @override
  State<BasicColor> createState() => _BasicColorState();
}

class _BasicColorState extends State<BasicColor> {
  ColorList colorList = ColorList();
  late List<ColorItem> colors;
  List<ColorItem> assignToStudent = [];
  int _index = 0;
  late int len;
  List<String> imageList = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState? _state;
  final CarouselController _controller = CarouselController();
  int activateIndex = 0;

  bool _isPlaying = false;
  bool carouselAutoPlay = false;
  bool _isPaused = true;

  Widget _colorCard() {
    if (imageList.isEmpty) {
      loadData();
      return const CircularProgressIndicator();
    } else if (_state?.processingState != ProcessingState.ready) {
      loadAudio();
      return const CircularProgressIndicator();
    } else {
      return colorCardWidget();
    }
  }

  _BasicColorState() {
    _index = 0;
  }

  @override
  initState() {
    loadData().then((List<String> value) {
      if (value.isNotEmpty) {
        loadAudio().then((value) {
          _colorCard();
        });
      }
    });

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _state = state;
      });
    });
    super.initState();
  }

  Future<List<String>> loadData() async {
    colors = colorList.getList();
    if (colors.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 150));
      return await loadData();
    }
    len = colors.length;
    imageList = colors[_index].imgList;

    return imageList;
  }

  Future loadAudio() async {
    await _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.file(colors[_index].audio)),
        initialPosition: Duration.zero,
        preload: true);

    _audioPlayer.setLoopMode(LoopMode.one);
    return _audioPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        stop();
        setState(() {});

        Navigator.pop(context);

        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Colour',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  stop();
                  setState(() {});
                  var result = await showSearch<String>(
                    context: context,
                    delegate: ColorSearch(colors),
                  );
                  setState(() {
                    _index = max(0,
                        colors.indexWhere((element) => element.text == result));
                    //_audioPlayer.play();
                  });
                },
                icon: const SafeArea(child: Icon(Icons.search_sharp)))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            //resizeTo
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _colorCard(),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      //print('prev');
                      //print(_state?.processingState);
                      //_audioPlayer.stop();
                      stop();

                      setState(() {
                        //loading();

                        _isPlaying = false;

                        try {
                          _index = (_index - 1) % len;
                        } catch (e) {
                          //print(e);
                        }
                        //print(_state?.processingState);
                      });
                    },
                    label: const Text(
                      'Prev',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    icon: const Icon(
                      Icons.navigate_before,
                    ),
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      minimumSize: const Size(100, 42),
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                      icon: (_isPaused)
                          ? const Icon(Icons.play_circle_outline)
                          : const Icon(Icons.pause_circle_filled),
                      iconSize: 40,
                      onPressed: () {
                        if (!_isPaused) {
                          //print('---------is playing true-------');
                          pause(); //stop()
                        } else {
                          //print('-------is playing false-------');
                          play();
                        }
                      }),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      //print('next');
                      //print(_state);
                      //_audioPlayer.stop();
                      stop();
                      setState(() {
                        //loading();

                        try {
                          _index = (_index + 1) % len;
                        } catch (e) {
                          //print(e);
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Text('Next',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.navigate_next_rounded),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      minimumSize: const Size(100, 42),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 25.0),
            FloatingActionButton.extended(
              heroTag: 'btn1',
              onPressed: () {
                stop();
                teachStudent();
              },
              icon: const Icon(Icons.add),
              label: const Text('Assign to student',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            const Spacer(),
            FloatingActionButton.extended(
              heroTag: 'btn2',
              onPressed: () {
                // setState(() {
                stop();
                // });
                // Navigator.pushNamed(
                //     context, '/nounForm').then((value) { setState(() {}); //.then((_) => setState(() {
                //       Noun();
                //     }));
                Navigator.of(context)
                    .pushNamed('/nounForm')
                    .then((value) => setState(() {}));
              },
              icon: const Icon(Icons.add),
              label: const Text('Add a Noun',
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future stop() async {
    //future async
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _isPaused = true;
      carouselAutoPlay = false;
    });
  }

  pause() {
    _audioPlayer.pause();
    setState(() {
      _isPaused = true;
      carouselAutoPlay = false;
    });
  }

  Future play() async {
    //print('play called and ............................');
    //print(_state?.processingState);
    _audioPlayer.play();
    // if (result == 1) {
    setState(() {
      _isPlaying = true;
      _isPaused = false;
      carouselAutoPlay = true;
    });
    //}
  }

  Widget colorCardWidget() {
    ColorItem color = colors.elementAt(_index);
    List<String> images = color.getImgList();
    //print('noun card widget');
    //print(_index);
    //print(name.text);

    // setState(() {
    //   _audioPlayer.play();
    // });
    //
    //_audioPlayer.play();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 420,
                  width: 600,
                  child: CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: images.length,
                    options: CarouselOptions(
                        height: 385.0,
                        initialPage: 0,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: carouselAutoPlay,
                        //pageSnapping: false,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1400),
                        viewportFraction: 0.8,
                        pauseAutoPlayOnManualNavigate: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            //images = widget.name.getImgList();
                            // if (index >= images.length)
                            //   activateIndex = 0;
                            // else
                            activateIndex = index;
                            //print(activateIndex);
                          });
                        }),
                    itemBuilder: (context, index, realIndex) {
                      if (index >= images.length) {
                        index = 0;
                        //print('called 22');
                      }
                      final img = images[index];

                      return buildImage(img, index);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                buildIndicator(images),
              ],
            ),
            SizedBox(
              width: 500,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Checkbox(
                          value: color.isSelected,
                          onChanged: (value) {
                            setState(() {
                              color.isSelected = !color.isSelected;
                              if (color.isSelected) {
                                assignToStudent.add(colors[_index]);
                              } else {
                                assignToStudent.remove(colors[_index]);
                              }
                            });
                          }),
                      // const SizedBox(
                      //     width: 300), //Spacer(), //const SizedBox(height: 20.0),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              colorList.removeItem(color);
                            });
                          },
                          icon: const Icon(Icons.delete_forever_rounded)),
                      //const SizedBox(height: 20.0),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Card(
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const <Widget>[
                                  Text(
                                    'Noun: ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  //SizedBox(height: 10),
                                  Text(
                                    'Meaning:',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //const SizedBox(width: 20.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Card(
                            //margin: const EdgeInsets.all(122.0),
                            color: Colors.blue[400],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    color.text,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  //const SizedBox(height: 10),
                                  Text(
                                    color.meaning,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const Text('To be modified',
                  //     style:
                  //         TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String img, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey,
      child: Image.file(
        File(img),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget buildIndicator(List<String> images) => AnimatedSmoothIndicator(
        activeIndex: activateIndex % images.length,
        count: images.length,
        effect: const JumpingDotEffect(
          //SwapEffect
          activeDotColor: Colors.blue,
          dotColor: Colors.black12,
          dotHeight: 10,
          dotWidth: 10,
        ),
        onDotClicked: animateToSlide,
      );

  void animateToSlide(int index) {
    // if (index > images.length) {
    //   index = 0;
    // }
    try {
      _controller.animateToPage(index);
    } catch (e) {
      //print(e);
      throw Exception(e);
    }
  }

  Future teachStudent() async {
    if (assignToStudent.isEmpty) {
      //alert popup
      _showMaterialDialog();
    } else {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        // User canceled the picker
      } else {
        selectedDirectory.replaceAll('\\', '/');
        //print('selected directory ' + selectedDirectory);
        File(selectedDirectory + '/noun.txt').createSync(recursive: true);
        _write(File(selectedDirectory + '/noun.txt'));
        copyImage(selectedDirectory);
        copyAudio(selectedDirectory);
      }
    }
  }

  Future<void> copyAudio(String destination) async {
    for (ColorItem color in assignToStudent) {
      File file = File(color.audio);
      await file.copy(destination + '/${file.path.split('/').last}');
    }
  }

  Future<void> copyImage(String destination) async {
    for (ColorItem color in assignToStudent) {
      String folder = color.dir.split('/').last;
      final newDir =
          await Directory(destination + '/$folder').create(recursive: true);
      final oldDir = Directory(color.dir);

      await for (var original in oldDir.list(recursive: false)) {
        if (original is File) {
          await original
              .copy('${newDir.path}/${original.path.split('\\').last}');
        }
      }
    }
  }

  Future _write(File file) async {
    for (ColorItem color in assignToStudent) {
      //print(name.text + ' ' + name.meaning);
      await file.writeAsString(
          color.text +
              '; ' +
              color.meaning +
              '; ' +
              color.dir +
              '; ' +
              color.audio +
              '\n',
          mode: FileMode.append);
    }

    // String line = text + '; ' + meaning + '; ' + dir + '; ' + audio;
    // //addNoun(text, meaning, dir);
    // return file.writeAsString('\n$line', mode: FileMode.append);
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('No item was selected'),
            content:
                const Text('Please select at least one item before assigning'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: const Text('Close')),
            ],
          );
        });
  }
}

ColorSearch(List<ColorItem> colors) {}
