import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

final usersRef = Firestore.instance.collection('library');

class FireBaseData extends StatefulWidget {
  @override
  _FireBaseDataState createState() => _FireBaseDataState();
}

class _FireBaseDataState extends State<FireBaseData> {
  final List<Widget> _dataListWidget = List<Widget>();
  List<Widget> _dataListWidget2 = List<Widget>();

  @override
  void initState() {
    getFirebaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('books'),
      ),
      body: Container(
          //  padding: EdgeInsets.only(top: 50),
          child: _dataListWidget.toList() == null
              ? Center(
                  child: Container(
                    child: Text('Waiting'),
                  ),
                )
              : Container(
                  child: ListView(
                    padding: EdgeInsets.only(right: 20),
                    children: <Widget>[Column(children: _dataListWidget)],
                  ),
                )),
    );
  }

  Color myColor({String MyString}) {
    if (MyString.contains('متنوع')) return Colors.brown;

    if (MyString.contains('رواية')) return Colors.deepOrangeAccent;
    if (MyString.contains('اطفال')) return Colors.amber;
    if (MyString.contains('لغة')) return Colors.blue;
    if (MyString.contains('اعلام'))
      return Colors.red;
    else
      return Colors.black;
  }

  Widget rowWidget({DocumentSnapshot doc}) {
    /*_dataListWidget2 = [];

    doc['ImageUrl'].asMap().forEach((i, m) {
      setState(() {

        _dataListWidget2.add(
          RotatedBox(
            quarterTurns: -1,
            child: Text(
              doc['ImagesTitles'][i],
            ),
          ),
        );
      });
    });*/

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 150),
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: doc['ImageUrl'].toList().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: myColor(MyString: doc['Type']),
            child: Row(
              children: <Widget>[
                Image.network(
                  doc['ImageUrl'][index],
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    doc['ImagesTitles'][index],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  getFirebaseData() async {
    final QuerySnapshot snapshot = await usersRef.getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        _dataListWidget.add(Container(
          padding: EdgeInsets.only(bottom: 15),
          child: doc["ImageUrl"].toList().length > 0
              ? rowWidget(doc: doc)
              : Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Image.network(
                        doc["ImageUrl"][0].toString(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Text(
                            doc["pris"],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            doc["title"],
                            style: GoogleFonts.almarai(fontSize: 20),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ));
        /*  mm.add(Column(
          children: <Widget>[
            Text(doc["title"]),
            Text(doc["pris"]),
          ],
        )); */
      });
    });
  }
}
