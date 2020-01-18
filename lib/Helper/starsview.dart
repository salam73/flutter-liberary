import 'package:flutter/material.dart';
import 'package:bookhouse2/screens/screentwo.dart';

class StarsView extends StatelessWidget {
  const StarsView({
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
          BoxConstraints(maxHeight: 230), // **THIS is the important part**
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
                      dice: data[index]['attachments']['data'][0]
                          ['description'],
                      myList: myList,
                      index: index,
                      src: data[index]['attachments']['data'][0]['media']
                          ['image']['src']),
                ),
              );
            },
            child: Container(
                child: Card(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.network(
                        data[index]['attachments']['data'][0]['media']['image']
                            ['src'],
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          data[index]['attachments']['data'][0]['description'],
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
