import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kids_learning_tool/Quiz/Puzzle/jigsaw_puzzle_page.dart';

class PuzzleQuestion extends StatefulWidget {
  const PuzzleQuestion({Key? key}) : super(key: key);

  @override
  _PuzzleQuestionState createState() => _PuzzleQuestionState();
}

class _PuzzleQuestionState extends State<PuzzleQuestion> {
  String _selectedFile = '';
  late File file;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlinedButton(
              onPressed: () {
                _openFileExplorer();
              },
              child: const Text(
                'Select an Image',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              )),
          const SizedBox(width: 5),
          Text(_selectedFile), //files.last.path.split('\\').last
          const SizedBox(width: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 60), elevation: 3),
            onPressed: () {
              if (_selectedFile.isNotEmpty) {
                Navigator.of(context).push(
                  // With MaterialPageRoute, you can pass data between pages,
                  // but if you have a more complex app, you will quickly get lost.
                  MaterialPageRoute(
                    builder: (context) => JigsawPuzzlePage(file),
                  ),
                );
              }
            },
            child: const Text(
              'Preview',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openFileExplorer() async {
    //File file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp'],
    );

    if (result != null) {
      file = File((result.files.single.path)!);
      setState(() {
        _selectedFile = file.path.split('\\').last;
      });
    } else {
      // User canceled the picker
    }
  }
}
