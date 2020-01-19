import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: isn't this a screen. It should move to the screen folder
class MySearch extends StatefulWidget {
  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          color: Colors.grey,
          onPressed: () => {},
          child: Text(
            "salam", // TODO: remove
            style: GoogleFonts.cairo(
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
