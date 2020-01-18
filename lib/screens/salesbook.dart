import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'screentwo.dart';

class Salesbook extends StatefulWidget {
  Salesbook({this.fontSize});

  final int fontSize;

  @override
  _SalesBookState createState() => _SalesBookState();
}

class _SalesBookState extends State<Salesbook> {
  final String url = "http://caffena.dk/salam.json";
  List data;

  List<String> myList = List();

  Future getSWData() async {
    var res = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    setState(() {
      var resBody = json.decode(utf8.decode(res.bodyBytes));
      data = resBody["feed"]["data"];
    });

    data.forEach((n) {
      if (data != null) {
        for (String line
            in n['attachments']['data'][0]['description'].split('\n')) {
          var parts = line.split(':');
          if (parts.length == 1) {
            //  print('invalid: $line');
            {
              myList.add("invalid: $line");
            }
          } else {
            String fieldName = (parts[0]);
            String fieldValue = (parts[1]);
            if (parts[0].contains("عنوان")) myList.add(parts[1]);

            print('$fieldName ------- $fieldValue');
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: 150), // **THIS is the important part**
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: data == null ? 0 : 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Card(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data[index + 2]['attachments']['data'][0]['description'],
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Image.network(
                  data[index + 2]['attachments']['data'][0]['media']['image']
                      ['src'],
                ),
              ],
            ),
          ));
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}
