import 'package:bookhouse2/screens/newwidget.dart';
import 'package:bookhouse2/service/fetchdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Widget> images = List();

  //Column myColumn = Column();

  List myListId = List();

  int _crossAxisCount = 2;

  /* salam({String documentID}) {
    debugPrint(documentID);
  }
*/
  Future _getData() async {
    Stream<QuerySnapshot> _mySnap = usersRef.snapshots();

    await _mySnap.forEach((m) {
      QuerySnapshot mySnapShot = m;

      mySnapShot.documents.forEach((myDocuments) {
        // print(myDocuments.data);

        // print(myDocuments.data["ImageUrl"]);

        var myListImageUrl = myDocuments.data["ImageUrl"];
        List myTitles = myDocuments.data["ImagesTitles"];
        List<Widget> listOfImage = List();

       // print(myListImageUrl is List);

        if (myListImageUrl is List) {
          if (!mounted) return;
          setState(() {
            /* images.add(
              Center(
                child: Text(
                  myDocuments.data["title"],
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                ),
              ),
            ); */

            listOfImage.add(Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 6,
                      child: Image.network(
                        myListImageUrl[0].toString(),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: 150,
                        child: Text(
                          myDocuments.data["title"],
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: 150,
                        child: Text(
                          myDocuments.data["profileName"],
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    myListImageUrl.length > 1
                        ? Flexible(
                            child: Container(
                              width: 150,
                              child: Text(
                                'عدد الكتب ${myListImageUrl.length}',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          )
                        : Text(''),
                    // Text('there is ${myListImageUrl.length - 1} of pictures more')
                  ],
                ),
              ),
            ));


            images.add(GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewWidget(
                        myWidgets: myListImageUrl,
                        myTitle: myTitles,
                        mytitle: myDocuments.data["title"],
                      ),
                    ));
              },
              child: Container(
                // color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listOfImage.toList(),
                ),
              ),
            ));

            // print("title= ${myDocuments.data["title"]}");
          });
        } else {
          // print("title (false)= ${myDocuments.data["title"]}");
          // print(myListImageUrl);
          if (!mounted) return;
          setState(() {
            images.add(Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  //Text(myDocuments.data["title"]),
                  (Image.network(
                    myDocuments.data["ImageUrl"],
                    //width: 150,
                    height: 150,
                  )),
                ],
              ),
            ));
          });
        }

        //print("-----------------------------------");
      });
    });
    /* return Container(
        child: ListView(

      children: images.toList(),
    ));*/
  }

  @override
  void initState() {
    // TODO: implement initState

    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.collections,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _crossAxisCount = 3;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _crossAxisCount = 2;
              });
            },
          ),
        ],
      ),
      body: images.length > 0
          ? GridView.count(
               childAspectRatio: 0.8,

              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: _crossAxisCount,
              // Generate 100 widgets that display their index in the List.
              children: images,
            )
          : Center(
              child: Container(
                child: Text('Waiting'),
              ),
            ),
    );
  }
}
