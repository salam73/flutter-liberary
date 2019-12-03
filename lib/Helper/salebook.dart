import 'package:flutter/material.dart';



class Salebook extends StatelessWidget {
  const Salebook({
    Key key,
    @required this.data,
    @required this.myList,
  }) : super(key: key);

  final List data;
  final List<String> myList;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 100), // **THIS is the important part**
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: data == null ? 0 : 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(myList[index]),
                    ),
                    Image.network(
                      data[index]['attachments']['data'][0]['media']
                      ['image']['src'],
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}