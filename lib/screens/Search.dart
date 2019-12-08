import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Widget> images = List();

  Column myColumn = Column();

  List myListId = List();

  salam({String documentID}) {
    debugPrint(documentID);
  }

   Widget noor()  {
    usersRef.snapshots().forEach((m) {
      QuerySnapshot mySnapShot = m;

      mySnapShot.documents.forEach((myDocuments) {
        // print(myDocuments.data);

        // print(myDocuments.data["ImageUrl"]);

        var myList = myDocuments.data["ImageUrl"];
        List myTitles = myDocuments.data["ImagesTitles"];
        List<Widget> ListOfImage = List();

        print(myList is List);

        if (myList is List) {
          images.add(
              Center(child: Text(myDocuments.data["title"], style: TextStyle(color: Colors.blue),)));

          myList.asMap().forEach((index, m) {
            print("imagesTitles=${m}");

            ListOfImage.add(
                Column(

              children: <Widget>[
                Image.network(
                  m.toString(),
                  width: 120,
                  height: 120,
                ),
                Text(myTitles[index], style: TextStyle(color: Colors.white),)
              ],
            ));
          });

          images.add(Container(
           color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ListOfImage.toList(),
            ),
          ));

          print("title= ${myDocuments.data["title"]}");
        } else {
          print("title (false)= ${myDocuments.data["title"]}");
          print(myList);

          images.add(Column(
            children: <Widget>[
              Text(myDocuments.data["title"]),
              (Image.network(
                myDocuments.data["ImageUrl"],
                width: 150,
                height: 150,
              )),
            ],
          ));
        }

        print("-----------------------------------");
      });
    });
    return Container(
        child: ListView(

      children: images.toList(),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    //noor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: //noor ()
         StreamBuilder<QuerySnapshot>(
          stream: usersRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Text('Waiting'),

              );
            }


snapshot.data.documents.forEach((m){

  print(m.data['ImageUrl'].toString());
});


            final List<Column> children = snapshot.data.documents
                .map((doc) => Column(



              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [


                Image.network(doc['ImageUrl'][0].toString(), width: 50, height: 50,),
                Image.network(doc['ImageUrl'][1].toString(), width: 50, height: 50,),



                Text(doc.documentID),

              // myList = doc.data["ImageUrl"];

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
