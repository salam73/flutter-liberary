import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class SearchScreen extends StatelessWidget {
  List<String> MyList = List();

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

  List<Widget> listToImags(DocumentSnapshot doc) {
    List<Widget> images = [];
    List<Widget> images2 = [];
    List<Widget> images3 = [];
    List<String> ListImagesTitles = [];
    List<String> ListImageUrl = [];
    List<String> images4 = [];

    List myListing = doc['ImageUrl'] as List;

    doc.data.forEach((index, value) {
      //   print (value);

      if (value is List) {
        // print(doc['title']);
      }

      //  print (doc['ImagesTitles'][index])
    });

    for (String url in doc['ImageUrl']) {
      Widget img = Flexible(
        flex: 6,
        child: GestureDetector(
          onTap: () {
            print(doc['ImagesTitles']);
          },
          child: (Image.network(
            url,
            width: 100,
            height: 100,
          )),
        ),
      );
      // Widget img2 = Text(url , );

      images.add(img);
      ListImagesTitles.add(url);
    }
    for (String url in doc['ImagesTitles']) {
      //  Widget img = Image.network(url , width: 100, height: 100,);
      Widget img2 = RotatedBox(
        quarterTurns: -1,
        child: Text(
          url, //(url)  مهم تذكر هذا الشيء واستخدام ما بين القوسين
          // textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
      );
      images2.add(img2);
      ListImageUrl.add(url);
    }
    images3 = merge(images, images2).toList();
    images4 = merge(ListImagesTitles, ListImageUrl).toList();
/*
    Map<int, Widget> map = images3.asMap();

    map.forEach((index, w) {
      images4.add(Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // color: Colors.pink,

        child: w,
      ));
    });*/
    // print(images4);

    return images3;
  }

  Column listofColumn(doc) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'العنوان:${doc['title']}',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'الكاتب :${doc['profileName']}',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
        Container(
            color: Colors.black12,
            // alignment: Alignment.topLeft,

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: listToImags(doc),
              ),
            ))
      ],
    );
  }

  Column listofColumnWinthouImage(doc) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'العنوان:${doc['title']}',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'الكاتب :${doc['profileName']}',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
        /*  Container(
          color: Colors.black12,
            // alignment: Alignment.topLeft,

            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: listToImags(doc),
          ),
        )) */
      ],
    );
  }

  bool _getQuery({List imageTitles, String profileTitles, String myQuery}) {
    bool _queryResualt =
        imageTitles.any((a) => a.toString().contains(myQuery)) ||
            profileTitles.contains(myQuery);
    return _queryResualt;
  }

  List<Column> _getSearchData() {}

  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _mySnap = usersRef.snapshots();

    _mySnap.forEach((mySnapShot) {
      mySnapShot.documents.forEach((myDocuments) {
        // print(myDocuments['ImagesTitles'].toString());
        // print(myDocuments['ImageUrl'].toString());

        List myList = myDocuments['ImagesTitles'] as List;

        myList.asMap().forEach((index, value) => {
              //  print(myDocuments['ImagesTitles'][index].toString()),
              //  print(myDocuments['ImageUrl'][index].toString()),

              MyList.add(myDocuments['ImagesTitles'][index].toString()),
              MyList.add(myDocuments['ImageUrl'][index].toString()),
            });
        // print(MyList);
      });
    });

    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: (Text('Waiting')),
            );
          }

          //final resualt= usersRef.snapshots().data.where((a) => a.title.toLowerCase().contains('f'));
          final List<Column> children = snapshot.data.documents
              /* .where((a) => (a['ImagesTitles'].toList().length > 1)
                  ? _getQuery(myList: a['ImagesTitles'], myQuery: '')
                  : a['ImagesTitles'][0].toString().contains(''))*/
              .map(
                (doc) => listofColumn(doc),
              )
              .toList();

          return Scaffold(
              appBar: AppBar(
                title: Text('البحث عن كتاب'),
                backgroundColor: Colors.green,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: SearchBook());
                    },
                  )
                ],
              ),
              body: Text('salam')
              // ExpandableListView()
              );
        });
  }
}

class SearchBook extends SearchDelegate<Widget> {
  SearchScreen myClassRefrance = SearchScreen();

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
            return Center(
              child: Text('Waiting'),
            );
          }

          //final resualt= usersRef.snapshots().data.where((a) => a.title.toLowerCase().contains('f'));

          final List<Column> children = snapshot.data.documents
              .where((a) => (a['ImagesTitles'].toList().length > 1)
                  ? myClassRefrance._getQuery(
                      imageTitles: a['ImagesTitles'],
                      profileTitles: a['profileName'],
                      myQuery: query)
                  : a['ImagesTitles'][0].toString().contains(query) ||
                      a['profileName'].contains(query) ||
                      a['title'].contains(query))
              .map(
                (doc) => myClassRefrance.listofColumn(doc),
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
                  ? myClassRefrance._getQuery(
                      imageTitles: a['ImagesTitles'],
                      profileTitles: a['profileName'],
                      myQuery: query)
                  : a['ImagesTitles'][0].toString().contains(query) ||
                      a['profileName'].contains(query) ||
                      a['title'].contains(query))
              .map(
                (doc) => myClassRefrance.listofColumnWinthouImage(doc),
              )
              .toList();
          if (query.length > 0)
            return ListView(
              children: children,
            );
          return Center(
            child: Text(
              'اكتب اسم الكتاب أو اسم المؤالف',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          );
        });
  }

  @override
  String get searchFieldLabel => "إكتب عنوان الكتاب أو اسم المؤلف";
}
