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
  static String accesstoken =
      "EAAC5ryfjvqABAAAtJrhxyM0M6JCw2gkZCZBZBnMA9QfCAAOoQKDRxsZCVpfmaZAxiYaZAs1007w9HEhxNab2iCoiPx6tHZCgEcGRtlZCI85foW4JbTx9TlmgZASjDffMl1mGNjp2gRZALWmkd5YFPYLVfZAqfrfZA0cFbmXG0rjMl60DcLPKeC9imEV2yUcpSZAHLvk0n3a34fwk8ZBwZDZD";
  final String url =

 "https://graph.facebook.com/v5.0/me?fields=feed%7Bmessage%2Cattachments%7Bsubattachments%2Cdescription%2Cmedia%7D%2Ccreated_time%7D&access_token=EAAC5ryfjvqABAAAtJrhxyM0M6JCw2gkZCZBZBnMA9QfCAAOoQKDRxsZCVpfmaZAxiYaZAs1007w9HEhxNab2iCoiPx6tHZCgEcGRtlZCI85foW4JbTx9TlmgZASjDffMl1mGNjp2gRZALWmkd5YFPYLVfZAqfrfZA0cFbmXG0rjMl60DcLPKeC9imEV2yUcpSZAHLvk0n3a34fwk8ZBwZDZD"


 ;



  List _data;
  List _subData;
  List<String> listOfTitle = List();
  List<String> listOfItem = List();
  List<String> listOfImages = List();
  List<String> listOfDescription = List();

  @override
  void initState() {
   // getData();
    // createUserInFireCloud();
    super.initState();
  }

  Future getData() async {
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
              listOfTitle.add("invalid: $line");
            }
          } else {
            String fieldName = (parts[0]);
            String fieldValue = (parts[1]);
            if (parts[0].contains("عنوان")) {
              listOfTitle.add(parts[1]);
            }

            print('$fieldName ------- $fieldValue');
            listOfItem.add(fieldValue);

          }
        }

        listOfItem.add(_data[index]['created_time']);

        if (_data[index]['attachments']['data'][0]['media'] != null) {
          listOfItem.add(
              _data[index]['attachments']['data'][0]['media']['image']['src']);







          listOfImages.add(_data[index]['attachments']['data'][0]['media']['image']['src']);
          listOfDescription.add(listOfItem[0]);

          createUserInFireCloud2(
              userName: listOfItem,
              listImages: listOfImages,
              listTitles: listOfDescription);

          //createUserInFireCloud(userName: listOfItem);


        }

        if (_data[index]['attachments']['data'][0]['subattachments'] != null) {
          _subData =
          _data[index]['attachments']['data'][0]['subattachments']['data'];

          _subData.forEach((n) {
            listOfImages.add(n['media']['image']['src']);
            if (n['description'] != null)
              listOfDescription.add(n['description']);
            else
              listOfDescription.add("");
          });

         createUserInFireCloud2(
              userName: listOfItem,
              listImages: listOfImages,
              listTitles: listOfDescription);
        }

        listOfItem = [];
        listOfImages = [];
        listOfDescription = [];
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: getData,
        child: Text('getData'),
      ),
    );
  }
}