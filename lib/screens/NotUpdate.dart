import 'package:cached_network_image/cached_network_image.dart';
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

  @override
  Iterable<T> merge<T>(Iterable<T> c1, Iterable<T> c2) sync* {
    var it1 = c1.iterator;
    var it2 = c2.iterator;
    var active = true;
    while (active) {
      active = false;
      if (it1.moveNext()) {
        active = true;
        yield it1.current;
      }

      if (it2.moveNext()) {
        active = true;
        yield it2.current;
      }
    }
  }

  List<Widget> listWidget({List data}) {
    myList = [];
    //List<dynamic> myHani=data.removeAt(0);

    data.forEach((f) {
      if (f is Map<String, dynamic>) if (f['ImagesTitles'].length == 1)
        myList.add(Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              f['ImagesTitles'][0].toString(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
              ),
              textDirection: TextDirection.rtl,
            ),
            CachedNetworkImage(
              imageUrl: f['ImageUrl'][0].toString(),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 150,
            )
          ],
        ));
      else {
        Map<String, dynamic> salam = f;

        List<Widget> WrapText = [];
        List<Widget> WrapImage = [];
        List<Widget> WrapTextImage = [];

        salam.forEach((i, d) {
          //print(d.runtimeType);

          if (i == 'ImageUrl') {
            List m = d.toList();
            m.forEach((g) {
              WrapImage.add(CachedNetworkImage(
                imageUrl: g.toString(),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 100,
              ));
            });
          }

          if (i == 'ImagesTitles') {
            List m = d.toList();
            m.forEach((g) {
              WrapText.add(
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(g.toString()),
                ),
              );
            });

            //WrapTextImage.add(Text())
          }
        });

        WrapTextImage = merge(WrapImage, WrapText).toList();

        myList.add(
          Wrap(children: WrapTextImage),
        );
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
          title: Text(
            'تصنيف الكتب عن طريق الأقسام',
            textDirection: TextDirection.rtl,
          ),
        ),
        body: ListView(children: myListTitle));
  }
}
