import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kids_learning_tool/Animation/bouncing_button.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Addition extends StatefulWidget {
  //const Addition({ Key? key }) : super(key: key);

  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  Random random = Random();
  int upper_limit = 10;
  String sign = '+';
  late List<int> temp; // = [0, 0];
  late List<int> options; // = [0, 0, 0];

  int first_number = 1;
  int second_number = 1;
  int answer = 0;

  @override
  void initState() {
    super.initState();
    first_number = random.nextInt(upper_limit) + 1;
    second_number = random.nextInt(upper_limit) + 1;
    temp = [0, 0];
    options = [0, 0, 0];
    answer = first_number + second_number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text.rich(TextSpan(children: [
            TextSpan(
                text: 'Basic Calculation',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ]))),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '$first_number',
                      style: TextStyle(
                        fontSize: 120,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Colors.brown[600],
                      )),
                ])),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < (first_number / 3).ceil(); i++)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [..._getIcons(first_number, 0)]),
                    ]),
              ]),
          //
          //
          SizedBox(
            width: 30,
            //color: Colors.blueAccent,
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: sign,
                  style: TextStyle(
                    fontSize: 80,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[700],
                  )),
            ])),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '$second_number',
                      style: TextStyle(
                        fontSize: 120,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Colors.brown[600],
                      )),
                ])),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < (first_number / 3).ceil(); i++)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [..._getIcons(second_number, 1)]),
                    ]),
              ]),
          SizedBox(
            width: 30,
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: '=',
                  style: TextStyle(
                    fontSize: 80,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[700],
                  )),
            ])),
          ),
          SizedBox(
            width: 30,
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: '=',
                  style: TextStyle(
                    fontSize: 80,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[700],
                  )),
            ])),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ..._getOptions(),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _getIcons(int number, int index) {
    List<Widget> friendsTextFields = [];
    int x = 0;
    if (temp[index] + 3 <= number) {
      x = 3;
      temp[index] += 3;
      //print(temp);
    } else {
      x = number - temp[index];
      temp[index] += x;
      if (temp[index] == number) {
        temp[index] = 0; // check-failed again okay?
        friendsTextFields.clear();
      }
      //print(temp);
    }
    for (int i = 0; i < x; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: const [
            Icon(
              FontAwesome5Solid
                  .candy_cane, //bicycle //FontawesomeIcons.candycane
              color: Colors.brown,
              size: 50,
            ),
            SizedBox(width: 20),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  List<Widget> _getOptions() {
    List<Widget> friendsTextFields = [];
    options[0] = first_number + second_number;
    options[1] = options[1] + random.nextInt(5) + 1;
    options[2] = random.nextInt(options[1]);
    options.shuffle(); //check again

    for (int i = 0; i < 3; i++) {
      friendsTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: BouncingButton('${options[i]}'),
        ),
      );
    }
    return friendsTextFields;
  }
}
