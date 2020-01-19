import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = Firestore.instance.collection('library');

// TODO: not used anywhere ... remove

class GetFBD {
  final List myList;

  GetFBD(this.myList);
}
