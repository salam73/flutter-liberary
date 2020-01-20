import 'package:bookhouse2/screens/home.dart';
import 'package:bookhouse2/service/theme.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
     // title: 'Book House', // TODO: remove
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
       // fontFamily: 'almarai',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic, color: Colors.white)
         // body1: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
        ),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Home(),
        //SplashScreen(),
      )
      //home: Search(),
      ));
}
