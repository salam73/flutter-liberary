import 'package:bookhouse2/screens/home.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book House', // TODO: remove
      theme: ThemeData(
        primaryColor: Colors.red,
        //scaffoldBackgroundColor: Color(0xffffde03),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Home(),
        //SplashScreen(),
      )
      //home: Search(),
      ));
}
