import 'package:bookhouse2/screens/slider.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  final List dbList;

  const IntroScreen({Key key, this.dbList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SliderShow(
            dbList: dbList,
          ),
          Center(
            child: Text(
              'مقدمة عن المكتبة',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}
