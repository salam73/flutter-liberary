import 'package:flutter/material.dart';

class MyView extends StatelessWidget {
  MyView({this.data, this.myList});

  final List myList;
  final List data;

  final mynewList = List<Widget>();

  List<Widget> widgetList() {
    if (this.data != null)
      this.data.forEach((myl) {
        mynewList.add(Column(
          children: <Widget>[
            Image.network(
              myl['attachments']['data'][0]['media']['image']['src'],
              width: 150,
              height: 150,
            ),
          ],
        ));
      });
    return mynewList;
  }

  @override
  Widget build(BuildContext context) {
    //final title = 'Grid List';

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,

        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: widgetList(),
      ),
    );
  }
}
