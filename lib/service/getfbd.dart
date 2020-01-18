import 'package:bookhouse2/service/mysearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class GetFBD {
  final List mylist;

  GetFBD(this.mylist);

  //return   FB_dataList;

}
