import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  final List myWidgets;
  final List myTitleList;
  final String myTitle;

  NewWidget({this.myWidgets, this.myTitleList, this.myTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(myTitle),
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
                        flex: 6,
                        child: Text(
                          myTitleList[index],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: (Image.network(myWidgets[index])),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
