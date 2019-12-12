import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');


class GetFBD extends StatelessWidget {
  const GetFBD({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
 getData()async{
  
   
}

getData();

    return Center(
      child: Container(
        child: Text('salam'),
      ),
    );
  }
}