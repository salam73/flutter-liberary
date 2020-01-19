import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';

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
        body: Column(
          children: <Widget>[
            Text(dice),
            PinchZoomImage(
              image: CachedNetworkImage(
                imageUrl: src,
              ),
              zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
              hideStatusBarWhileZooming: true,
            ),
          ],
        ));
  }
}
