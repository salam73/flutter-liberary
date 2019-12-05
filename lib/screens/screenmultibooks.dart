import 'package:flutter/material.dart';

class ScreenMultiBooks extends StatelessWidget {
  ScreenMultiBooks({
    this.title,
    this.colors,
    @required this.data,
    @required this.myList,
  });

  final String title;
  final Color colors;

  final List data;
  final List<String> myList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: colors,
      ),
      body: ListView.builder(
       // scrollDirection: Axis.horizontal,

        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                elevation: 9,
                color: colors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
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
            ),
          );
        },
      ),
    );
  }
}
