import 'package:flutter/material.dart';

class MyView extends StatelessWidget {
  MyView({this.data, this.myList});

  final List myList;
  final List data;

  final myNewList = List<Widget>();

  List<Widget> widgetList() {
    if (this.data != null)
      this.data.forEach((myl) {
        myNewList.add(Column(
          children: <Widget>[
            Image.network(
              myl['attachments']['data'][0]['media']['image']['src'],
              width: 150,
              height: 150,
            ),
          ],
        ));
      });
    return myNewList;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
        crossAxisCount: 2,
        children: widgetList(),
      ),
    );
  }
}
