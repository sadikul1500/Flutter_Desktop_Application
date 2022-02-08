import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Number extends StatefulWidget {
  @override
  _NumberState createState() => _NumberState();
}

class _NumberState extends State<Number> {
  int number = 10;
  List<String> numbers = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber[300],
      appBar: AppBar(
          centerTitle: true,
          title: const Text.rich(TextSpan(children: [
            TextSpan(
                text: 'Number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ]))),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Icon(
                //   number % 2 == 0
                //       ? FontAwesomeIcons.seedling
                //       : FontAwesomeIcons.solidLemon,
                //   color: Colors.green,
                //   size: 50,
                // ),
                ..._getIcons(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: '$number',
                              style: TextStyle(
                                fontSize: 200,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue[700],
                              ))
                        ]),
                      ),
                    ),
                    Card(
                      //margin: const EdgeInsets.all(122.0),
                      color: Colors.blue[700],
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: numbers[number - 1],
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ))
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ]),
    );
  }

  List<Widget> _getIcons() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < 8; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Icon(
          number % 2 == 0
              ? FontAwesomeIcons.seedling
              : FontAwesomeIcons.solidLemon,
          color: Colors.green,
          size: 50,
        ),
      ));
    }
    return friendsTextFields;
  }
}
