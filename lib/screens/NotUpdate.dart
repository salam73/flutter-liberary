import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class ExpandableListView extends StatefulWidget {
  /* static final List<String> _listViewData = [
    "Inducesmile.com",
    "Flutter Dev",
    "Android Dev",
    "iOS Dev!",
    "React Native Dev!",
    "React Dev!",
    "express Dev!",
    "Laravel Dev!",
    "Angular Dev!",
  ]; */

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  List dataList = [];
  List sortTypeArray = [];
  List typeItemArray = [];
  List widgetItemArray = [];
  List mysetList = [];
  List mysetListTitle = [];
  List<Widget> myList;

  List<ExpansionTile> myListTitle;

  getFirebaseData() async {
//print(itemsTypeArray);

    final QuerySnapshot snapshot = await usersRef
        //  .where("Type", isEqualTo: "اطفال")
        .orderBy('Type')
        .getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        dataList.add(doc.data);
      });
    });

    dataList.forEach((m) => {sortTypeArray.add(m['Type'])});

    sortTypeArray =
        sortTypeArray.toSet().toList(); //remove duplicate items of list
    //print(sortTypeArray);

    sortTypeArray.forEach((m) {
      typeItemArray.add(m.toString());

      dataList.forEach((f) {
        if (f['Type'] == m) {
          //  print(   mysalamList.every((f)=>f['Type'] == m));

          typeItemArray.add(f);

          // typeItemArray.add(f);

          /* setState(() {
            myWidgetList.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(f['profileName']),
              ),
            );
          }); */

        } else {
          return;
        }
        widgetItemArray.add(typeItemArray);
      });
      typeItemArray = [];
    });
    // print(widgetItemArray.toSet());

    mysetList = widgetItemArray.toSet().toList();
  }

  @override
  void initState() {
    getFirebaseData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> listWidget({List data}) {
    myList = [];
    //List<dynamic> myHani=data.removeAt(0);

    data.forEach((f) {
      if (f is Map<String, dynamic>) if (f['ImagesTitles'].length == 1)
        myList.add(Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(f['ImagesTitles'][0].toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                )),
            Image.network(
              f['ImageUrl'][0].toString(),
              width: 150,
            ),
          ],
        ));
      else {
        Map<String, dynamic> salam = f;
        salam.forEach((i, d) {
          //print(d.runtimeType);
          if (i == 'ImagesTitles') {
            List m = d.toList();
            m.forEach((g) {
              myList.add(Text(g.toString()));
            });
          }
          if (i == 'ImageUrl' ) {
            List<Widget> mdd = [];
            List m = d.toList();
            m.forEach((g) {
              mdd.add(Image.network(
                g.toString(),
                width: 100,
              ));
            });

            myList.add(
              Wrap(children: mdd),
            );
          }
        });
      }
    });

    return myList;
  }

  @override
  Widget build(BuildContext context) {
    //if (myListTitle.length < 1)
    myListTitle = mysetList
        .map((data) => ExpansionTile(
            title: Text(data[0].toString()), children: listWidget(data: data)))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Expandable ListView Example'),
        ),
        body: ListView(children: myListTitle));
  }
}
