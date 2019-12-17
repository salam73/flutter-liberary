import 'package:bookhouse2/screens/Home.dart';
import 'package:bookhouse2/screens/Search.dart';

import 'package:flutter/material.dart';





void main() {
  runApp(

      MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Passing Data',
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
    home: Home(),

    //home: Search(),
  ));

}
