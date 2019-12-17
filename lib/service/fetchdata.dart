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
  String accesstoken = "";

  String url =
      "https://graph.facebook.com/v5.0/me?fields=feed%7Bmessage%2Cattachments%7Bsubattachments%2Cdescription%2Cmedia%7D%2Ccreated_time%7D&access_token=";

  final myController = TextEditingController();

  List _data;
  List _subData;
  List<String> my_items = List();
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
      accesstoken = myController.value.text;
      url = url + accesstoken;
      accesstoken = '';
      myController.text='';
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
              my_items.add("invalid: $line");
            }
          } else {
            String fieldName = (parts[0]);
            String fieldValue = (parts[1]);
            if (parts[0].contains("عنوان")) {
              my_items.add(parts[1]);
            }

            print('$fieldName ------- $fieldValue');
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
      "title": userName[0],
      "profileName": userName[1],
      "pris": userName[2],
      "pages": userName[3],
      "Type": userName[4],
      "Time": userName[5],
      "ImageUrl": userName[6],
    });
  }

  createUserInFireCloud2(
      {List<String> userName,
      List<String> listImages,
      List<String> listTitles}) async {
    await usersRef.document().setData({
      "title": userName[0],
      "profileName": userName[1],
      "pris": userName[2],
      "pages": userName[3],
      "Type": userName[4],
      "Time": userName[5],
      "ImageUrl": listImages,
      "ImagesTitles": listTitles
    });
  }

  deleteData() {}

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                
                  hintText: 'Enter a Token'),
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
