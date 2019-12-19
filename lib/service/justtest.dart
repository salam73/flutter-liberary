import 'package:flutter/material.dart';

class Justtest extends StatefulWidget {
  Justtest({Key key}) : super(key: key);

  @override
  _JusttestState createState() => _JusttestState();
}

class _JusttestState extends State<Justtest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('salam'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
    );
  }
}