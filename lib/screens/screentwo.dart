import 'package:cached_network_image/cached_network_image.dart';
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
      body: 
      
       Column(
         children: <Widget>[
           Center(
             child: CachedNetworkImage(
                      imageUrl: src,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    //  width: 100,
                    ),
           ),
           Text(dice)
         ],
       )
      
      
    );
  }
}
