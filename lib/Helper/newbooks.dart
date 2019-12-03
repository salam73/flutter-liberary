import 'package:flutter/material.dart';
import 'package:bookhouse2/screens/screentwo.dart';


class Newbook extends StatelessWidget {
  const Newbook({
    Key key,
    @required this.data,
    @required this.myList,
  }) : super(key: key);

  final List data;
  final List<String> myList;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
      BoxConstraints(maxHeight: 180), // **THIS is the important part**
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenTwo(
                      dice:  data[index]['attachments']['data'][0]['description'],
                      myList: myList,
                      index: index,
                      src: data[index]['attachments']['data'][0]['media']
                      ['image']['src']),
                ),
              );
            },
            child: Card(
              elevation: 9,
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data[index]['attachments']['data'][0]['description'],
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Image.network(
                    data[index]['attachments']['data'][0]['media']['image']
                    ['src'],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}