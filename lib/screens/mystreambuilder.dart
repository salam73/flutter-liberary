import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class MyStreamBuilder extends StatelessWidget {
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

    bool _getQuery({List myList}) {
      bool myBool = myList.any((a) => a.toString().contains(''));

      return myBool;
    }

    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return (Text('Waiting'));
          }

          //final resualt= usersRef.snapshots().data.where((a) => a.title.toLowerCase().contains('f'));
          final List<Column> children = snapshot.data.documents
              .where((a) => (a['ImagesTitles'].toList().length > 1)
                  ? _getQuery(myList: a['ImagesTitles'])
                  : a['ImagesTitles'][0].toString().contains(''))
              .map(
                (doc) => listofColumn(doc),
              )
              .toList();

          //Container(child: Image.network(doc['ImageUrl'][0], width: 100, height: 100,))

          return Scaffold(
            appBar: AppBar(
              title: Text('list'),
              backgroundColor: Colors.green,
              actions: <Widget>[
                IconButton(

                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: Searchbook());
                  },
                )
              ],
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

class Searchbook extends SearchDelegate<Widget> {
  bool _getQuery({List myList}) {
    bool myBool = myList.any((a) => a.toString().contains(query));

    return myBool;
  }

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


  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }



  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return (Text('Waiting'));
          }

          //final resualt= usersRef.snapshots().data.where((a) => a.title.toLowerCase().contains('f'));
          final List<Column> children = snapshot.data.documents
              .where((a) => (a['ImagesTitles'].toList().length > 1)
                  ? _getQuery(myList: a['ImagesTitles'])
                  : a['ImagesTitles'][0].toString().contains(query))
              .map(
                (doc) => listofColumn(doc),
              )
              .toList();

          return ListView(
            children: children,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return (Text('Waiting'));
          }

          //final resualt= usersRef.snapshots().data.where((a) => a.title.toLowerCase().contains('f'));
          final List<Column> children = snapshot.data.documents
              .where((a) => (a['ImagesTitles'].toList().length > 1)
                  ? _getQuery(myList: a['ImagesTitles'])
                  : a['ImagesTitles'][0].toString().contains(query))
              .map(
                (doc) => listofColumn(doc),
              )
              .toList();

          return ListView(
            children: children,
          );
        });
  }

  @override
  String get searchFieldLabel => "بحث";
}
