import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_icons/flutter_icons.dart';

class Addition extends StatefulWidget {
  //const Addition({ Key? key }) : super(key: key);

  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  Random random = Random();
  int upper_limit = 10;
  String sign = '+';
  List<int> temp = [0, 0];
  List<int> options = [0, 0, 0];

  int first_number = 1;
  int second_number = 1;

  @override
  void initState() {
    super.initState();
    first_number = random.nextInt(upper_limit) + 1;
    second_number = random.nextInt(upper_limit) + 1;
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
                        fontSize: 100,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Colors.yellow[700],
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
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: sign,
                  style: TextStyle(
                    fontSize: 80,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.yellow[700],
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
                        fontSize: 100,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Colors.yellow[700],
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
                    color: Colors.yellow[700],
                  )),
            ])),
          ),
          Column(
            children: <Widget>[
              ..._getIcons(2,1),
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
      //print(temp);
    }
    for (int i = 0; i < x; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: const [
            Icon(
              FontAwesomeIcons.appleAlt,
              color: Colors.green,
              size: 50,
            ),
            SizedBox(width: 20),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }
}
