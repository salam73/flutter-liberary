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

  deletData() {
    usersRef.getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
  }

  Widget build(BuildContext context) {
    List<Widget> listToImags(DocumentSnapshot urls) {
      List<Widget> images = [];
      List<Widget> images2 = [];
      List<Widget> images3 = [];
      List<Widget> images4 = [];

      for (String url in urls['ImageUrl']) {
        Widget img = Flexible(
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
        Widget img2 = RotatedBox(
          quarterTurns: -1,
          child: Text(
            url, //(url)  مهم تذكر هذا الشيء واستخدام ما بين القوسين
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        );
        images2.add(img2);
      }
      images3 = merge(images, images2).toList();

      Map<int, Widget> map = images3.asMap();

      map.forEach((index, w) {
        images4.add(Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // color: Colors.pink,

          child: w,
        ));
      });

      return images3;
    }

    Column listofColumn(doc) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('العنوان:${doc['title']}'),
          ),
          Container(
            // alignment: Alignment.topLeft,

            child: doc['ImageUrl'] is List
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: listToImags(doc),
                    ),
                  )
                : (Image.network(
                    doc['ImageUrl'],
                  )),
          )
        ],
      );
    }

    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return (Text('Waiting'));
          }

          final List<Column> children = snapshot.data.documents
              .map(
                (doc) => listofColumn(doc),
              )
              .toList();

          //Container(child: Image.network(doc['ImageUrl'][0], width: 100, height: 100,))

          return Scaffold(
            appBar: AppBar(
              title: Text('list'),
              backgroundColor: Colors.green,
            ),
            body: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: deletData,
                  color: Colors.grey,
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                      child: ListView(
                    children: children,
                  )),
                ),
              ],
            ),
          );
        });
  }
}
