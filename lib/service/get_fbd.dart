import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = Firestore.instance.collection('library');

class GetFBD {
  final List mylist;

  GetFBD(this.mylist);
}
