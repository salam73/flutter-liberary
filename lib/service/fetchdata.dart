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
  final String url =

  "https://graph.facebook.com/v4.0/me?fields=feed%7Bmessage%2Cattachments%7Bsubattachments%2Cdescription%2Cmedia%7D%2Ccreated_time%7D&access_token=EAAC5ryfjvqABAERJXTIiTOkKl9FICFU1ClNaTIrnImcNgzIKOLkIyU82UppZAcZCr8KzizvgbcqqZBVWTzrMj5xi4EsdHSnQakFU4HFZCKgUH9djrb5YkZB5p0RbcdvqaJAXm4ZBEE9JsxVpzQDHAhd2xp8mzWCjocOc8oJJoLkaSld0Spz4A1oAHFkGweCI8ZD";

   List data;
  List data2;
  List<String> listOfTitle = List();
  List<String> ListOfItem = List();
  List<String> ListOfImages = List();
  List<String> ListOfDescription = List();

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
            ListOfItem.add(fieldValue);
            //print('salam is a good boy');
            // createUserInFireCloud(UserName: fieldValue);
          }
        }

        ListOfItem.add(data[index]['created_time']);

        if (data[index]['attachments']['data'][0]['media'] != null) {
          ListOfItem.add(
              data[index]['attachments']['data'][0]['media']['image']['src']);
          createUserInFireCloud(UserName: ListOfItem);
        }

        if (data[index]['attachments']['data'][0]['subattachments'] != null) {
          data2 =
              data[index]['attachments']['data'][0]['subattachments']['data'];

          data2.forEach((n) {
            ListOfImages.add(n['media']['image']['src']);
            if(n['description']!=null)
              ListOfDescription.add(n['description']);
            else
              ListOfDescription.add("");
          });




          createUserInFireCloud2(
              UserName: ListOfItem, ListImages: ListOfImages, ListTitles: ListOfDescription);
        }



        ListOfItem = [];
        ListOfImages=[];
        ListOfDescription=[];
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
