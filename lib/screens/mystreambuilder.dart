import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyStreamBuilder extends StatelessWidget {
  final usersRef = Firestore.instance.collection('library');

  @override
  Iterable<T> merge<T>(Iterable<T> c1, Iterable<T> c2) sync* {
    var it1 = c1.iterator;
    var it2 = c2.iterator;
    var active = true;
    while (active) {
      active = false;
      if (it1.moveNext()) {
        active = true;
        yield it1.current;
      }

      if (it2.moveNext()) {
        active = true;
        yield it2.current;
      }
    }
  }

  Widget build(BuildContext context) {



    List<Widget> listToImags(DocumentSnapshot urls) {
      List<Widget> images = [];
      List<Widget> images2 = [];

      for (String url in urls['ImageUrl']) {
        Widget img = Expanded(
          flex: 6,
          child: (Image.network(
            url,
            width: 100,
            height: 100,
          )),
        );
        // Widget img2 = Text(url , );
        images.add(img);
      }
      for (String url in urls['ImagesTitles']) {
        //  Widget img = Image.network(url , width: 100, height: 100,);
        Widget img2 = Expanded(
          flex: 4,
          child: (Text(
            url,
          )),
        );
        images2.add(img2);
      }

      return merge(images, images2).toList();
    }

    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return (Text('Waiting'));
          }

          final List<Column> children = snapshot.data.documents
              .map((doc) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(doc['title']),
                      Container(
                        child: doc['ImageUrl'] is List
                            ? Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          //color: Colors.pink,
                          elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                    children: listToImags(doc),
                                  ),
                              ),
                            )
                            : Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          //color: Colors.pink,
                          elevation: 10,


                                child: (Image.network(
                                  doc['ImageUrl'],
                                  width: 100,
                                  height: 100,
                                )),
                              ),
                      )
                    ],
                  ))
              .toList();

          //Container(child: Image.network(doc['ImageUrl'][0], width: 100, height: 100,))

          return Container(
            child: ListView(
              children: children,
            ),
          );
        });
  }
}
