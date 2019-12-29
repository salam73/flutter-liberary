import 'package:flutter/material.dart';
import 'dart:math' as math;

class Tyepscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container (
      child: new Stack (
        children: [
          new Image.network ( // background photo
            "https://scontent.fnjf5-1.fna.fbcdn.net/v/t1.0-9/78730372_10218468586659237_2833252589296943104_n.jpg?_nc_cat=101&_nc_eui2=AeEeU49-XGRXFtkU-UDUkvflbmbeDrAVgVVlkIH6esSjfuvWnXe3EKc91WoGOjaFcbs6I6LYocCFm4lByr0DnckfljSX686xXBbM8Tc5iJ2hVQ&_nc_ohc=1CN-uPk1aLIAQlF8BaedXJ9cvScQlaNqKvB7OFK43L3xEGH8BeZoLM1sA&_nc_ht=scontent.fnjf5-1.fna&oh=2e54d7441613fa1063758eca01463fff&oe=5EA2DB57",
            fit: BoxFit.cover,
          ),
          new Center (
            child: new Transform (
              child: new Container (
                child: new Text (
                    "Lorem ipsum",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 42.0,
                      fontWeight: FontWeight.w900,
                    )
                ),
                decoration: new BoxDecoration (
                  color: Colors.black,
                ),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              alignment: FractionalOffset.center, // set transform origin
              transform: new Matrix4.rotationZ(0.54533), // rotate -10 deg
            ),
          ),
        ],
      ),
      width: 400.0,
      height: 200.0,
    );
  }
}
