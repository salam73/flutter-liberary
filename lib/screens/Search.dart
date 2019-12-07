import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class Search extends StatefulWidget {



  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {


  List<Widget> images= List();

  Column myColumn= Column();

  List myListId= List();

salam({String documentID}){

  debugPrint(documentID);

}

Widget noor(){








usersRef.snapshots().forEach((m){

 QuerySnapshot mySnapShot= m;

 mySnapShot.documents.forEach((myDocuments){
  // print(myDocuments.data);



 // print(myDocuments.data["ImageUrl"]);


  var myList=myDocuments.data["ImageUrl"];
  List myTitles=myDocuments.data["ImagesTitles"];

  print(myList is List);

  if(myList is List) {
   myList.forEach((m){
     print("imagesTitles=${m}");
    // images.add(Image.network(m));
     images.add(Image.network(m.toString()));


   });
   print ("title= ${myDocuments.data["title"]}");

  }
  else{
    print ("title (false)= ${myDocuments.data["title"]}");
    print(myList);

  }

  if(myTitles!=null)
    {
      myTitles.forEach((f){
        print("ImagesTitle=${f}");
        images.add(Text(f));

      });


    }
print("-----------------------------------");




 });



});
  return  Container(
    child: ListView(
      children: images.toList(),
    )
  );

}


@override
  void initState() {
    // TODO: implement initState
  //noor(me: 3, Gooling: false);
  super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello'),),
        body:


noor()
      /*  StreamBuilder<QuerySnapshot>(
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

            // salam(documentID: doc.documentID),


              ],
            )).toList();



            return Container(
              child: ListView(
                children: children,
              ),
            );
          },
        ));*/

    );
}
}
