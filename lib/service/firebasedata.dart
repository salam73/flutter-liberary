import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


final usersRef = Firestore.instance.collection('library');



class FireBaseData extends StatefulWidget {
  @override
  _FireBaseDataState createState() => _FireBaseDataState();
}

class _FireBaseDataState extends State<FireBaseData> {

  @override
  void initState() {
    // TODO: implement initState
    getFirebaseData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("salam hadi"),
    );
  }

  getFirebaseData() async{
    final QuerySnapshot snapshot = await usersRef.getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc){

    print(doc["title"]);
    print(doc["profileName"]);
    print(doc["pris"]);
    print(doc["ImagesTitles"]);
    print(doc["Type"]);

    print(doc["ImageUrl"]);
    });

  }

}
