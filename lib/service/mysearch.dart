import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mysearch extends StatefulWidget {
  @override
  _MysearchState createState() => _MysearchState();
}

class _MysearchState extends State<Mysearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          color: Colors.grey,
          onPressed: () => {},
          child: Text(
            "salam",
            style: GoogleFonts.cairo(
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
