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

  static String accesstoken="EAAC5ryfjvqABANcZAfGrsSWcFpa3GiYOAZCi6q1zzDskXXCz6j0DkePwcql6PZBEoUkFhlxV6lGPZCV50RMSBUmAG0v3W26l3TaG3V19JGRG9wUpA11BcgjEIGxbrFecpKFyLPFvaZCnkePhv4yyirxTcqp1GYP9l3NewT6vZA94CCVpEvIlal6jxqTtZBy1ThnEDF0DSjMzgZDZD";
  final String url =


  "https://graph.facebook.com/v4.0/me?fields=feed%7Bmessage%2Cattachments%7Bsubattachments%2Cdescription%2Cmedia%7D%7D&access_token=EAAC5ryfjvqABANx26ynxh8mESvWAXhv19Qx8skzXr2LVka50E7eO7y4eUVMDBbN1IEZCuQHIuznvJ7LcaBVGZC9jvnJFENhs5I7xEqILOtRzT6oD2k2KXiWQa44tcAooHZC2yJ6NOaHkY1vhaQm7AM30NhT05n7TZBTxBDv8DxokZBz5iIxcSwbBwwXsH2dEZD";



  List data;
  List data2;
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
    data = resBody["feed"]["data"];
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

    data.forEach((n) {
      //print('Hello Mr. ${n['attachments']['data'][0]['description'].split('\n')}');∫∫√¶

      if (data.isNotEmpty) {
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
            //print('salam is a good boy');
            // createUserInFireCloud(UserName: fieldValue);
          }
        }

        listOfItem.add(data[index]['created_time']);

        if (data[index]['attachments']['data'][0]['media'] != null) {
          listOfItem.add(
              data[index]['attachments']['data'][0]['media']['image']['src']);
          createUserInFireCloud(UserName: listOfItem);
        }

        if (data[index]['attachments']['data'][0]['subattachments'] != null) {
          data2 =
              data[index]['attachments']['data'][0]['subattachments']['data'];

          data2.forEach((n) {
            listOfImages.add(n['media']['image']['src']);
            if(n['description']!=null)
              listOfDescription.add(n['description']);
            else
              listOfDescription.add("");
          });




          createUserInFireCloud2(
              UserName: listOfItem, ListImages: listOfImages, ListTitles: listOfDescription);
        }



        listOfItem = [];
        listOfImages=[];
        listOfDescription=[];
        index++;
      }
    });
  }

  createUserInFireCloud({List<String> UserName}) async {
    await usersRef.document().setData({
      "title": UserName[0],
      "profileName": UserName[1],
      "pris": UserName[2],
      "pages": UserName[3],
      "Type": UserName[4],
      "Time": UserName[5],
    "ImageUrl": UserName[6],

    });
  }

  createUserInFireCloud2(
      {List<String> UserName, List<String> ListImages, List<String> ListTitles}) async {
    await usersRef.document().setData({
      "title": UserName[0],
      "profileName": UserName[1],
      "pris": UserName[2],
      "pages": UserName[3],
      "Type": UserName[4],
      "Time": UserName[5],
      "ImageUrl": ListImages,
      "ImagesTitles":ListTitles
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
