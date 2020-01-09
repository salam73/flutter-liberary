import 'package:bookhouse2/screens/screentwo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = Firestore.instance.collection('library');

class Tyepscreen extends StatefulWidget {
  @override
  _TyepscreenState createState() => _TyepscreenState();
}

class _TyepscreenState extends State<Tyepscreen> {
  List textItem = [];
  List m = [];

  List<Widget> myWidgetList = [];
  List<Widget> myMaha = [];

  List dataList = [];
  List sortTypeArray = [];

  List mysetList = [];

  getFirebaseData() async {
//print(itemsTypeArray);
    List typeItemArray = [];
    List widgetItemArray = [];

    final QuerySnapshot snapshot = await usersRef
        //  .where("Type", isEqualTo: "اطفال")
        // .orderBy('Type')
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
    print(widgetItemArray.toSet());

    mysetList = widgetItemArray.toSet().toList();
  }

  @override
  void initState() {
    getFirebaseData();

    super.initState();
  }

  @override
  void dispose() {
    // myWidgetList = [];
    super.dispose();
  }

  Color myColor({String myString}) {
    if (myString.contains('متنوع')) return Colors.brown;

    if (myString.contains('رواية')) return Colors.deepOrangeAccent;
    if (myString.contains('اطفال')) return Colors.amber;
    if (myString.contains('لغة')) return Colors.blue;
    if (myString.contains('اعلام'))
      return Colors.red;
    else
      return Colors.black;
  }

  Widget rowWidget({var doc}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 150),
      child: ListView.builder(
        // itemExtent: 100,
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: doc['ImageUrl'].toList().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: myColor(myString: doc['Type']),
            child: Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenTwo(
                            dice: doc['ImagesTitles'][index],
                            myList: null,
                            index: index,
                            src: doc['ImageUrl'][index],
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: doc['ImageUrl'][index],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 100,
                    )),
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    doc['ImagesTitles'][index],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    myWidgetList = [];

    return Scaffold(
        appBar: AppBar(
          title: Text('books'),
        ),
        body: mysetList.length < 1
            ? Center(
                child: Container(
                  child: Text('Waiting'),
                ),
              )
            : Center(
                child: ListView.builder(

                    itemCount: 1,
                    itemBuilder: (BuildContext ctxt, int index) {
                      mysetList.asMap().forEach((index2, f) => {
                            m = f.toList(),
                            m.asMap().forEach((i, x) => {
                                  i == 0
                                      ? {
                                          myWidgetList.add(
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              /*color: Colors.lightBlue[
                                                  100 * (index2 % 9)],*/
                                              color:Colors.lightGreen,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    x.toString(),
                                                    style: TextStyle(
                                                      fontSize: 30, color: Colors.white

                                                      // color: Colors.grey[100 * (index2 % 9)],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        }
                                      : {
                                          myMaha.add(
                                            Container(
                                            /*  color: Colors
                                                  .lightBlue[100 * (i % 9)],*/
                                              // color: Colors.grey,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: x["ImageUrl"]
                                                              .toList()
                                                              .length >
                                                          1
                                                      ? Column(
                                                          children: <Widget>[
                                                              Text('سلسلة كتب عدد: ' +
                                                                  x["ImageUrl"]
                                                                      .toList()
                                                                      .length
                                                                      .toString()),
                                                              rowWidget(doc: x)
                                                            ])
                                                      : GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ScreenTwo(
                                                                  dice:
                                                                      x['ImagesTitles']
                                                                          [0],
                                                                  myList: null,
                                                                  index: index,
                                                                  src:
                                                                      x['ImageUrl']
                                                                          [0],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: x['ImageUrl'] [0],
                                                            placeholder: (context, url) => CircularProgressIndicator(),
                                                            errorWidget: (context, url, error) =>Icon(Icons.error),
                                                            width: 100,
                                                          ))),
                                            ),
                                          )
                                        }
                                }),
                            myWidgetList.add(
                              Container(
                                child: Wrap(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: myMaha),
                              ),
                            ),
                            myMaha = []
                          });

                      return Column(children: myWidgetList);
                    })));
  }
}
