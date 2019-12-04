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
  final String url = "http://caffena.dk/salam.json";
  List data;

  List<String> listOfTitle = List();
  List<String> ListOfItem = List();

  @override
  void initState() {
    getData();
    createUserInFireCloud();
    super.initState();
  }

  Future getData() async {
    int index = 0;

    var res = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    setState(() {
      var resBody = json.decode(utf8.decode(res.bodyBytes));
      data = resBody["feed"]["data"];
//posts.data[2].attachments.data[0].description
      //  String myData=resBody=["feed"]["data"][0]['attachments']['data'][0]['description'].toString();
    });

    data.forEach((n) {
      //print('Hello Mr. ${n['attachments']['data'][0]['description'].split('\n')}');∫∫√¶

      if (data.isNotEmpty) {
        for (String line
            in n['attachments']['data'][0]['description'].split('\n')) {
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
        ListOfItem.add(
            data[index]['attachments']['data'][0]['media']['image']['src']);
        createUserInFireCloud(UserName: ListOfItem);
        ListOfItem = [];
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
      "ImageUrl": UserName[5],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
