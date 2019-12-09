import 'dart:collection';

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

        print(myListImageUrl is List);

        if (myListImageUrl is List) {
          setState(() {
            images.add(
              Center(
                child: Text(
                  myDocuments.data["title"],
                  style: TextStyle(color: Colors.blue, fontSize: 30),
                ),
              ),
            );

            listOfImage.add(Column(
              children: <Widget>[
                Image.network(
                  myListImageUrl[0].toString(),
                  width: 120,
                  height: 120,
                ),
                Text(
                  myTitles[0],
                  style: TextStyle(color: Colors.black),
                ),
                Text('there is ${myListImageUrl.length - 1} of pictures more')
              ],
            ));

            myListImageUrl.asMap().forEach((index, m) {
              print("imagesTitles=${m}");

              /* listOfImage.add(Column(
                children: <Widget>[
                  Image.network(
                    m.toString(),
                    width: 120,
                    height: 120,
                  ),
                  Text(
                    myTitles[index],
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ));*/
            });

            /*  ListOfImage.add(
              Column(

                children: <Widget>[
                  Image.network(
                    myList[0].toString(),
                    width: 250,
                    height: 250,
                  ),
                  Text(
                    myTitles[0], style: TextStyle(color: Colors.white, fontSize: 30),)
                ],
              ));*/

            images.add(GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewWidget(
                        myWidgets: myListImageUrl,
                        myTitle: myTitles,
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


        } else
          {
         // print("title (false)= ${myDocuments.data["title"]}");
         // print(myListImageUrl);

          setState(() {
            images.add(Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  Text(myDocuments.data["title"]),
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
        ),
        body: images.length > 0
            ? Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    //reverse: true,
                    itemCount: images == null ? 0 : images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return images[index];
                    }),
              )
            : Center(
                child: Container(
                  child: Text('Waiting'),
                ),
              ));
  }
}
