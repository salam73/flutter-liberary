import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = Firestore.instance.collection('library');

class FetchData extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  String _accessToken = "";

  String url =
      "https://graph.facebook.com/v5.0/me?fields=feed%7Bmessage%2Cattachments%7Bsubattachments%2Cdescription%2Cmedia%7D%2Ccreated_time%7D&access_token=";

  final myController = TextEditingController();

  List _data;
  List _subData;
  List<String> _myItems = List();
  List<String> listOfItem = List();
  List<String> listOfImages = List();
  List<String> listOfTitles = List();

  @override
  void initState() {
    // getData();
    // createUserInFireCloud();
    super.initState();
  }

  Future getData() async {
    setState(() {
      _accessToken = myController.value.text;
      url = url + _accessToken;
      _accessToken = '';
      myController.text = '';
    });

    int index = 0;

    var res = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    var resBody = json.decode(utf8.decode(res.bodyBytes));
    _data = resBody["feed"]["data"];

    _data.forEach((n) {
      if (_data.isNotEmpty) {
        for (String line in n['message'].split('\n')) {
          var parts = line.split(':');
          if (parts.length == 1) {
            //  print('invalid: $line');
            {
              _myItems.add("invalid: $line");
            }
          } else {
            String fieldName = (parts[0]);
            String fieldValue = (parts[1]);
            if (parts[0].contains("عنوان")) {
              _myItems.add(parts[1]);
            }

            // print('$fieldName ------- $fieldValue');
            listOfItem.add(fieldValue);
          }
        }

        listOfItem.add(_data[index]['created_time']);

        if (_data[index]['attachments']['data'][0]['subattachments'] == null) {
          listOfItem.add(
              _data[index]['attachments']['data'][0]['media']['image']['src']);

          listOfImages.add(
              _data[index]['attachments']['data'][0]['media']['image']['src']);
          listOfTitles.add(listOfItem[0]);

          createUserInFireCloud2(
              userName: listOfItem,
              listImages: listOfImages,
              listTitles: listOfTitles);
        }
        //  listOfItem = [];

        if (_data[index]['attachments']['data'][0]['subattachments'] != null) {
          _subData =
              _data[index]['attachments']['data'][0]['subattachments']['data'];

          _subData.forEach((n) {
            listOfImages.add(n['media']['image']['src']);
            if (n['description'] != null)
              listOfTitles.add(n['description']);
            else
              listOfTitles.add("");
          });

          createUserInFireCloud2(
              userName: listOfItem,
              listImages: listOfImages,
              listTitles: listOfTitles);
        }

        listOfItem = [];
        listOfImages = [];
        listOfTitles = [];
        index++;
      }
    });
  }

  createUserInFireCloud({List<String> userName}) async {
    await usersRef.document().setData({
      "title": userName[0].trim(),
      /* "profileName": userName[1].trim(),
      "pris": userName[2].trim(),
      "pages": userName[3].trim(), */
      "Type": userName[1].trim(),
      "Time": userName[2],
      "ImageUrl": userName[6],
    });
  }

  createUserInFireCloud2(
      {List<String> userName,
      List<String> listImages,
      List<String> listTitles}) async {
    if (userName.length < 4)
      await usersRef.document().setData({
        "title": userName[0].trim(),
        "profileName": '',
        "pris": '',
        "pages": '',
        "Type": userName[1].trim(),
        "Time": userName[2],
        "ImageUrl": listImages,
        "ImagesTitles": listTitles
      });
    else
      await usersRef.document().setData({
        "title": userName[0].trim(),
        "profileName": userName[1].trim(),
        "pris": userName[2].trim(),
        "pages": userName[3].trim(),
        "Type": userName[4].trim(),
        "Time": userName[5],
        "ImageUrl": listImages,
        "ImagesTitles": listTitles
      });
  }

  deletData() {
    usersRef.getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: deletData,
              child: Text('deletData'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter a Token'),
              controller: myController,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: getData,
              child: Text('getData'),
            ),
          ),
        ],
      ),
    );
  }
}
