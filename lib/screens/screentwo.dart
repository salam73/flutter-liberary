import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ScreenTwo extends StatelessWidget {
  // Declare a field that holds the Todo.

  // In the constructor, require a Todo.
  final List<String> myList;
  final int index;
  final String src;
  final String dice;

  ScreenTwo({this.myList, this.index, this.src, this.dice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "كتب جديدة",
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Image.network(
            src,
          ),
    );
  }
}
