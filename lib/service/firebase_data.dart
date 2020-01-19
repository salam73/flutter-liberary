import 'package:bookhouse2/screens/screen_two.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

final usersRef = Firestore.instance.collection('library');

class FireBaseData extends StatefulWidget {
  final List dbList;

  const FireBaseData({Key key, this.dbList}) : super(key: key);

  @override
  _FireBaseDataState createState() => _FireBaseDataState();
}

class _FireBaseDataState extends State<FireBaseData> {
  List<Widget> _dataListWidget = List<Widget>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _dataListWidget = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getFirebaseData(widget.dbList);

    List<Widget> mylist = [Column(children: _dataListWidget)];

    return ListView(
      children: mylist,
    );
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

  Widget rowWidget({doc}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 150),
      child: ListView.builder(
        reverse: false,
        scrollDirection: Axis.horizontal,
        itemCount: doc['ImageUrl'].toList().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            // color: myColor(myString: doc['Type']),
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
                    width: 100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  getFirebaseData(List dataList) {
    dataList.forEach(
      (doc) {
        _dataListWidget.add(
          Column(
            children: <Widget>[
              Text(
                "كتب " + doc["Type"],
                style: GoogleFonts.almarai(fontSize: 15),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: doc["ImageUrl"].toList().length > 1
                    ? rowWidget(doc: doc)
                    : Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: <Widget>[
                                /* Text(
                                doc["pris"],
                                style: TextStyle(fontSize: 20),
                              ),*/
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    doc["title"],
                                    style: GoogleFonts.almarai(fontSize: 20),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: CachedNetworkImage(
                              imageUrl: doc["ImageUrl"][0].toString(),
                              placeholder: (context, url) =>
                                  Image.asset('assets/loading.gif'),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              width: 100,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
