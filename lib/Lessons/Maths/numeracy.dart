import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Number extends StatefulWidget {
  const Number({Key? key}) : super(key: key);

  @override
  _NumberState createState() => _NumberState();
}

class _NumberState extends State<Number> {
  int number = 1;
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ]))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(FontAwesomeIcons.apple),
          
      ),
    );
  }
}
