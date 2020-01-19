import 'package:bookhouse2/screens/screentwo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'slider.dart';

final usersRef = Firestore.instance.collection('library');

class Tyepscreen extends StatefulWidget {
  final List dbList;

  const Tyepscreen({Key key, this.dbList}) : super(key: key);

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
        .orderBy('Type')
        .getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        dataList.add(doc.data);
      });
    });

    widget.dbList.forEach((m) => {sortTypeArray.add(m['Type'])});

    sortTypeArray = sortTypeArray.toSet().toList();

    //remove duplicate items of list
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
      constraints: BoxConstraints(maxHeight: 160),
      child: ListView.builder(
        // itemExtent: 100,
        reverse: false,
        scrollDirection: Axis.horizontal,
        itemCount: doc['ImageUrl'].toList().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 7,
            //color: myColor(myString: doc['Type']),

            child: Row(
              children: <Widget>[
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    doc['ImagesTitles'][index],
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    //style: TextStyle(color: Colors.white),
                  ),
                ),
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
                          Image.asset('assets/loading.gif'),
                      errorWidget: (context, url, error) => Icon(Icons.error),

                      fit: BoxFit.fill,
                    )),
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
    Center salam() {
      return mysetList.length < 1
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
                          m.asMap().forEach((i, typeTitle) => {
                                i == 0
                                    ? {
                                        myWidgetList.add(
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            /*color: Colors.lightBlue[
                                                  100 * (index2 % 9)],*/
                                            // color:Colors.lightGreen,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  typeTitle.toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black

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
                                                padding: const EdgeInsets.all(8.0),
                                                child: typeTitle["ImageUrl"] .toList() .length > 1
                                                    ? Column(children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Text('كتب'),
                                                            Text('أكثر')
                                                          ],
                                                        ),
                                                        /* Text('سلسلة كتب عدد: ' +
                                                                  x["ImageUrl"]
                                                                      .toList()
                                                                      .length
                                                                      .toString()),*/

                                                        rowWidget(
                                                            doc: typeTitle)
                                                      ])
                                                    : GestureDetector(
                                                        onTap: () {
                                                          Navigator.push( context,
                                                            MaterialPageRoute(
                                                              builder: (context) => ScreenTwo(
                                                                dice: typeTitle['ImagesTitles'][0],
                                                                myList: null,
                                                                index: index,
                                                                src: typeTitle['ImageUrl'][0],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: typeTitle['ImageUrl'][0],
                                                          placeholder: (context,url) => Image.asset('assets/loading.gif'),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                          width: 120,
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
                  }));
    }

    return Column(
      children: <Widget>[
         /* Expanded(
              flex:2,
              child: SliderShow(dbList: widget.dbList,),
            ),*/
        Expanded(
          flex: 3,
          child: salam(),
        ),
      ],
    );
  }
}
