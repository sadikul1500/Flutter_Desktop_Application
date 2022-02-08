import 'dart:math';

import 'package:flutter/material.dart';

class Addition extends StatefulWidget {
  //const Addition({ Key? key }) : super(key: key);

  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  Random random = Random();
  int upper_limit = 10;
  String sign = '+';

  late int first_number = random.nextInt(upper_limit) + 1;
  late int second_number = random.nextInt(upper_limit) + 1;
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
                ]))
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
                ]))
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
        ],
      ),
    );
  }
}
