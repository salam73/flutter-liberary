import 'package:bookhouse2/screens/screentwo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

final usersRef = Firestore.instance.collection('library');

class FireBaseData extends StatefulWidget {
  @override
  _FireBaseDataState createState() => _FireBaseDataState();
}

class _FireBaseDataState extends State<FireBaseData> {
  List<Widget> _dataListWidget = List<Widget>();
  //List<Widget> _dataListWidget2 = List<Widget>();

  @override
  void initState() {
    getFirebaseData();
    super.initState();
  }

  @override
  void dispose() {
    _dataListWidget = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> mylist = [Column(children: _dataListWidget)];

    return Scaffold(
      body: CustomScrollView(
        slivers:
            // _sliverList(5, 10),
            <Widget>[
          SliverAppBar(
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('المكتبة العامة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.asset(
                  'assets/home.jpg',
                  fit: BoxFit.cover,
                )),
            floating: false,
            pinned: true,
            snap: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(mylist),
          ),
        ],
      ),
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

  Widget rowWidget({DocumentSnapshot doc}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 150),
      child: ListView.builder(
        reverse: false,
        scrollDirection: Axis.horizontal,
        itemCount: doc['ImageUrl'].toList().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: myColor(myString: doc['Type']),
            child: Row(
              children: <Widget>[
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    doc['ImagesTitles'][index],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
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
                    placeholder: (context, url) => CircularProgressIndicator(),
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

  Future getFirebaseData() async {
    List pariList = [];
    List itemList = [];
    List arrayitemList = [];
    final QuerySnapshot snapshot = await usersRef
        //  .where("Type", isEqualTo: "اطفال")
        .orderBy('Type')
        .getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      /*  setState(() {
        pariList.add(doc['Type']);
      }); */
    });

    var distinctIds = pariList.toSet().toList();
    //  print(pariList);
    //  print(distinctIds);

    snapshot.documents.forEach((DocumentSnapshot doc) {
      itemList.add(doc);
    });

    itemList.forEach((m) => {arrayitemList.add(m.data), print(arrayitemList)});

    print(arrayitemList);

    snapshot.documents.forEach((DocumentSnapshot doc) {
      if (!mounted) return;
      setState(() {
        _dataListWidget.add(
            Column(

             children: <Widget>[
            Text("كتب " + doc["Type"]),
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
                                padding: const EdgeInsets.only(right:8.0),
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
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: 100,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ));
      });
    });
  }
}
