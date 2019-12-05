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
      "https://graph.facebook.com/v4.0/me?fields=feed%7Bmessage%2Cattachments%7Bsubattachments%2Cdescription%2Cmedia%7D%7D&access_token=EAAC5ryfjvqABAF7kzbPaa1RvgbhYNwuGneLZCIHGlF2rC1JWTGX7BWSkPhPtuDnlI9kJpsSmdG7eJfPHYOWFWJj4oYzwd28ABE6q0GWzNx4ZBRqXUW6MYZBmijDA2c9Ek4sTZBBSbWQLwJHCybcmxT8MDt2kU5isRpn6G5litDHu55wLAQahn4edfDIIlFwZD";
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
    "ImageUrl": UserName[5],
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
      "ImageUrl": ListImages,
      "Titles":ListTitles
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
