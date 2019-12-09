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
      "EAAC5ryfjvqABANcZAfGrsSWcFpa3GiYOAZCi6q1zzDskXXCz6j0DkePwcql6PZBEoUkFhlxV6lGPZCV50RMSBUmAG0v3W26l3TaG3V19JGRG9wUpA11BcgjEIGxbrFecpKFyLPFvaZCnkePhv4yyirxTcqp1GYP9l3NewT6vZA94CCVpEvIlal6jxqTtZBy1ThnEDF0DSjMzgZDZD";
  final String url =


  "https://graph.facebook.com/v4.0/me?fields=feed%7Bmessage%2Cattachments%7Bsubattachments%2Cdescription%2Cmedia%7D%2Ccreated_time%7D&access_token=EAAC5ryfjvqABAEJaxbtxTtYv6eZAS8OKhu2sJ0CoxANZCroSoANwVsuAhW4BOGUYmsFEMqk7Hh4Ga8ZB5re5Iu2TBhOusxBWmurG9biHHwtnPAKQsMM5liqlqBHOQYtEyDDZAxUQ3qjFCo0YjCFSV7J4pncSZBx5DQaaCjNyMsHwJGVYZCZA2RBNpG07TvpGIOtGTccXu5OfQZDZD";

  List _data;
  List _subData;
  List<String> listOfTitle = List();
  List<String> listOfItem = List();
  List<String> listOfImages = List();
  List<String> listOfDescription = List();

  @override
  void initState() {
    getData();
    // createUserInFireCloud();
    super.initState();
  }

  Future getData() async {
    int index = 0;

    var res = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    var resBody = json.decode(utf8.decode(res.bodyBytes));
    _data = resBody["feed"]["data"];
//posts.data[2].attachments.data[0].description
    //  String myData=resBody=["feed"]["data"][0]['attachments']['data'][0]['description'].toString();

//feed.data[0].attachments.data[0].subattachments.data[0].media.image.src
//feed.data[0].attachments.data[0].subattachments.data[1].media.image.src
//feed.data[0].attachments.data[0].subattachments.data[2].media.image.src

//feed.data[1].attachments.data[0].subattachments.data[0].media.image.src
//feed.data[1].attachments.data[0].subattachments.data[1].media.image.src

// feed.data[1].attachments.data[0].subattachments.data[0].description
// feed.data[1].attachments.data[0].subattachments.data[1].description
//feed.data[0].created_time

    //feed.data[1].attachments.data[0].subattachments.data[0].description

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

          createUserInFireCloud(userName: listOfItem);
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
