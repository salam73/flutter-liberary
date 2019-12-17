import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  final List myWidgets;
  final List myTitle;
  final String mytitle;

  NewWidget({this.myWidgets, this.myTitle , this.mytitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mytitle),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: myWidgets == null ? 0 : myWidgets.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //width: double.infinity,
                  child: Row(
                    children: <Widget>[


                      Expanded(
                        flex: 9,
                        child: (Image.network(
                          myWidgets[index]

                        )),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text( myTitle[index], textAlign: TextAlign.center,)),
                    ],
                  ),
                ),
              );
            }));
  }
}
