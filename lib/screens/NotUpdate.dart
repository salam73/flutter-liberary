import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

List<Widget> wrapTextImage = [];

class ExpandableListView extends StatefulWidget {
  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  List FB_dataList = [];
  List sortTypeArray = [];
  List typeItemArray = [];
  List widgetItemArray = [];
  List setList = [];
  List setListTitle = [];
  List<Widget> myList;

  List<ExpansionTile> _WidgetExpansionTile;

  loadingData() async {
//print(itemsTypeArray);

    final QuerySnapshot snapshot = await usersRef
        //  .where("Type", isEqualTo: "اطفال")
        .orderBy('Type')
        .getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        FB_dataList.add(doc.data);
      });
    });

    FB_dataList.forEach((m) => {sortTypeArray.add(m['Type'])});

    sortTypeArray =
        sortTypeArray.toSet().toList(); //remove duplicate items of list
    //print(sortTypeArray);

    sortTypeArray.forEach((m) {
      typeItemArray.add(m.toString());

      FB_dataList.forEach((f) {
        if (f['Type'] == m) {
          typeItemArray.add(f);
        } else {
          return;
        }
        widgetItemArray.add(typeItemArray);
      });
      typeItemArray = [];
    });
    // print(widgetItemArray.toSet());

    setList = widgetItemArray.toSet().toList();
  }

  @override
  void initState() {
    loadingData();

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

  List<Widget> listWidget({List data, String title}) {
    myList = [];

    List<Widget> wrapTextWidget = [];

    List<Widget> wrapImageWidget = [];
    //List<dynamic> myHani=data.removeAt(0);

    data.forEach((f) {
      if (f is Map<String, dynamic>) if (f['ImagesTitles'].length == 1)
        myList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              f['ImagesTitles'][0].toString(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
              ),
              // textDirection: TextDirection.rtl,
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

        salam.forEach((i, item) {
          //print(d.runtimeType);
          if (i == 'ImagesTitles') {
            List m = item.toList();
            m.forEach((g) {
              wrapTextWidget.add(
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    g.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            });

            //WrapTextImage.add(Text())
          }
          if (i == 'ImageUrl') {
            List m = item.toList();
            m.forEach((g) {
              wrapImageWidget.add(CachedNetworkImage(
                imageUrl: g.toString(),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 100,
              ));
            });
          }
        });
      }
    });
    wrapTextImage = merge(wrapTextWidget,wrapImageWidget).toList();

    //ExpansionTile(title: Text('سلسلة كتب '+ title), children: wrapTextImage);
    if (wrapTextImage.length > 1)
      myList.add(
          ExpansionTile(title: Text('سلسلة كتب ' + title), children: <Widget>[
        Container(
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: wrapTextImage,
          ),
        )
      ]));

    return myList;
  }

  @override
  Widget build(BuildContext context) {
    //if (myListTitle.length < 1)
    _WidgetExpansionTile = setList
        .map(
          (data) => ExpansionTile(
            title: Text(data[0].toString()),
            children: listWidget(data: data, title: data[0].toString()),
          ),
        )
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تصنيف الكتب عن طريق الأقسام',
            textDirection: TextDirection.rtl,
          ),
        ),
        body: ListView(children: _WidgetExpansionTile));
  }
}
