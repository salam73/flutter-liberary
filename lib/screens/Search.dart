import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class Search extends StatefulWidget {



  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {


  List myListId= List();

salam({String documentID}){

  debugPrint(documentID);

}







  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello'),),
        body:


        StreamBuilder<QuerySnapshot>(
          stream: usersRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Text('Waiting'),

              );
            }




            final List<Column> children = snapshot.data.documents
                .map((doc) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(doc['title']),
                Text(doc.documentID),
               
            //  salam(documentID: doc.documentID),


              ],
            )).toList();



            return Container(
              child: ListView(
                children: children,
              ),
            );
          },
        ));





  }
}
