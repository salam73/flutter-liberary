import 'package:bookhouse2/screens/Home.dart';
import 'package:bookhouse2/screens/homescreen.dart';
import 'package:bookhouse2/service/splashscreen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter/material.dart';





void main() {
  runApp(

      MaterialApp(

    debugShowCheckedModeBanner: false,
    title: 'Book house',
    theme: ThemeData(
      primaryColor: Colors.red,
      //scaffoldBackgroundColor: Color(0xffffde03),
    ),
    home: Directionality(
      textDirection: TextDirection.rtl,

        child:Home()
      //SplashScreen(),
    )

    //home: Search(),
  ));

}
