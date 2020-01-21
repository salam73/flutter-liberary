import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');
List dataList = [];
List sortTypeArray = [];
List sortTypeArray2 = [];

List<Widget> widgetList = [];
List<Widget> widgetList2 = [];

class GridTypeScreen extends StatefulWidget {
  final List dbList;

  const GridTypeScreen({Key key, this.dbList}) : super(key: key);

  @override
  _GridTypeScreenState createState() => _GridTypeScreenState();
}

class _GridTypeScreenState extends State<GridTypeScreen> {
  getData() {
    setState(() {
      widget.dbList.forEach((m) => {sortTypeArray.add(m['Type'])});

      sortTypeArray =
          sortTypeArray.toSet().toList(); // remove duplicate Type title

      sortTypeArray2 = ['asd', 'fds', 'fdsasd', 'dsfasd'];
    });

    sortTypeArray.forEach((f) {
      setState(() {
        widgetList.add(
          Container(
            child: Center(child: Text(f.toString())),
          ),
        );
      });
    });
    print(sortTypeArray);
  }

  @override
  void initState() {
    // TODO: implement initState
    //widgetList=[];
    getData();
    super.initState();
  }

  @override
  void dispose() {
    widgetList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      children: widgetList,
      crossAxisCount: 3,
    );
  }
}
