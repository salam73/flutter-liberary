import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

final usersRef = Firestore.instance.collection('library');

class FireBaseData extends StatefulWidget {
  @override
  _FireBaseDataState createState() => _FireBaseDataState();
}

class _FireBaseDataState extends State<FireBaseData> {
  final List<Widget> mm = List<Widget>();
  @override
  void initState() {
    // TODO: implement initState
    getFirebaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 50),
        child: mm.toList() == null
            ? Center(
                child: Container(
                  child: Text('Waiting'),
                ),
              )
            : Container(
                child: ListView(
                  padding: EdgeInsets.only(right: 20),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("salam"),
                    ),
                    Column(children: mm)
                  ],
                ),
              ));
  }

   getFirebaseData() async {
    final QuerySnapshot snapshot = await usersRef.getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        mm.add(Container(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
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
                    Text(doc["title"], style: GoogleFonts.cairo(fontSize: 20),textDirection: TextDirection.rtl,),
                    Text(doc["pris"]),
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
