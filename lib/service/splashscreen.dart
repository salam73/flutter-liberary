import 'dart:async';

import 'package:bookhouse2/screens/Home.dart';
import 'package:bookhouse2/screens/introscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() =>  SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {



  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) =>  Home()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) =>  IntroScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
     Timer( Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntroScreen();
  }
}



