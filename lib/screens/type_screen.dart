import 'package:bookhouse2/screens/screen_two.dart';
//import 'package:bookhouse2/screens/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

final usersRef = Firestore.instance.collection('library');

class TypeScreen extends StatefulWidget {
  final List dbList;

  const TypeScreen({Key key, this.dbList}) : super(key: key);

  @override
  _TypeScreenState createState() => _TypeScreenState();

}

class _TypeScreenState extends State<TypeScreen> {
  List textItem = [];
  List m = [];

  List dbList2=[];

  List<Widget> myWidgetList = [];
  List<Widget> myMaha = [];

  List dataList = [];
  List sortTypeArray = [];

  List mySetList = [];

  getFirebaseData()  {
//print(itemsTypeArray);
    List typeItemArray = [];
    List widgetItemArray = [];

    /* final QuerySnapshot snapshot = await usersRef
        //  .where("Type", isEqualTo: "اطفال")
        .orderBy('Type')
        .getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        dataList.add(doc.data);
      });
    }); */

setState(() {
dbList2=widget.dbList;

   dbList2.forEach((m) => {sortTypeArray.add(m['Type'])});

    sortTypeArray = sortTypeArray.toSet().toList();// remove duplicate Type title
 sortTypeArray.forEach((m) {
      typeItemArray.add(m.toString());

      widget.dbList.forEach((f) {
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
    mySetList = widgetItemArray.toSet().toList();// get All items of current Type

});

   


   
    // print(widgetItemArray.toSet());

  }

  @override
  void initState() {
    getFirebaseData();

    super.initState();
  }

  @override
  void dispose() {
    // myWidgetList = [];
    //widget.dbList=[];
    dbList2=[];
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


  allWidget() {
    return mySetList.length < 1
        ? Center(
      child: Container(
        child: Text('Waiting'),
      ),
    )
        : ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext ctxt, int index) {


        mySetList.asMap().forEach((index2, f) => {
          m = f.toList(),
          m.asMap().forEach((i, typeTitle) => {
            i == 0// get the titleName Index form the List
                ? {
              myWidgetList.add(
                Container(
                  padding: EdgeInsets.all(10),
                  /*color: Colors.lightBlue[
                                              100 * (index2 % 9)],*/
                  // color:Colors.lightGreen,
                  child: Text(
                    typeTitle.toString(),
                    style: GoogleFonts.almarai(
                        fontSize: 25),
                  ),
                ),
              )
            }
                : {
              myMaha.add(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: typeTitle["ImageUrl"]
                      .toList()
                      .length >
                      1
                      ? Column(children: <Widget>[
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: <Widget>[
                        Text(
                          'كتب',
                          style:
                          GoogleFonts.almarai(
                              fontSize: 15),
                        ),
                        Text(
                          'المزيد-->',
                          style:
                          GoogleFonts.almarai(
                              fontSize: 15),
                        )
                      ],
                    ),
                    /* Text('سلسلة كتب عدد: ' +
                                                            x["ImageUrl"]
                                                                .toList()
                                                                .length
                                                                .toString()),*/

                    rowWidget(doc: typeTitle)
                  ])
                      : Container(
                    //width: 200,

                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScreenTwo(
                                  dice: typeTitle[
                                  'ImagesTitles'][0],
                                  myList: null,
                                  index: index,
                                  src: typeTitle[
                                  'ImageUrl'][0],
                                ),
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: typeTitle[
                            'ImageUrl'][0],
                            placeholder: (context,
                                url) =>
                                Image.asset(
                                    'assets/loading.gif'),
                            fit: BoxFit.fill,
                            errorWidget: (context,
                                url, error) =>
                                Icon(Icons.error),
                            width: 120,
                          ),
                          Text(
                            typeTitle[
                            'ImagesTitles'][0],
                            style: GoogleFonts
                                .almarai(
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            }
          }),
          myWidgetList.add(
            Card(
              elevation: 5,

              child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.start,
                  children: myMaha),
            ),
          ),
          myMaha = []
        });

        return Column(children: <Widget>[
          Container(
            child: Text('book store', style: GoogleFonts.almarai(fontSize: 15),),
          ),

        /*  SliderShow(
            dbList: dbList2,
          ),*/


          Column(children: myWidgetList)
        ],);
      },
    );


  }

  @override
  Widget build(BuildContext context) {
   // myWidgetList = [];



    myWidgetList = [];
    return  allWidget();
  }
}
