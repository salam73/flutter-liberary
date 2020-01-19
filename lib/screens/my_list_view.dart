import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'screen_multi_books.dart';
import 'package:bookhouse2/helper/sale_book.dart';
import 'package:bookhouse2/helper/new_books.dart';
import 'package:bookhouse2/helper/popular_book.dart';
import 'package:bookhouse2/helper/stars_view.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = "http://caffena.dk/salam.json";
  List data;

  List<String> listOfTitle = List();

  Future getSWData() async {
    var res = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    if (!mounted) return;
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
            {
              listOfTitle.add("invalid: $line");
            }
          } else {
            if (parts[0].contains("عنوان")) {
              listOfTitle.add(parts[1]);
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("دار الكتب"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  BookPart(
                    myTitle: 'إسلاميات',
                    colors: Colors.blue,
                    gotoscreen: ScreenMultiBooks(
                      title: "إسلاميات",
                      colors: Colors.blue,
                      data: data,
                      myList: listOfTitle,
                    ),
                  ),
                  BookPart(
                    myTitle: 'طب',
                    colors: Color(0xffea5462),
                    gotoscreen: ScreenMultiBooks(
                      title: "طب",
                      colors: Color(0xffea5462),
                      data: data,
                      myList: listOfTitle,
                    ),
                  ),
                  BookPart(
                    myTitle: 'علوم',
                    colors: Color(0xff46ceae),
                    gotoscreen: ScreenMultiBooks(
                      title: "علوم",
                      colors: Color(0xff46ceae),
                      data: data,
                      myList: listOfTitle,
                    ),
                  ),
                  BookPart(
                    myTitle: 'حاسوب',
                    colors: Color(0xfff6bc49),
                    gotoscreen: ScreenMultiBooks(
                      title: "حاسوب",
                      colors: Color(0xfff6bc49),
                      data: data,
                      myList: listOfTitle,
                    ),
                  ),
                  //  FetchData(),
                ],
              ),
            ),
            SeeAll(seeAllText: "كتب جديدةً"),
            NewBook(data: data, myList: listOfTitle),
            SeeAll(seeAllText: "الكتب الأكثر مبيعاً"),
            PopularBook(data: data, myList: listOfTitle),
            StarsView(data: data, myList: listOfTitle),
            SeeAll(seeAllText: "كتب مخفظة"),
            SaleBook(data: data, myList: listOfTitle),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}

class BookPart extends StatelessWidget {
  const BookPart({
    this.myTitle,
    this.colors,
    this.gotoscreen,
    Key key,
  }) : super(key: key);
  final String myTitle;
  final Color colors;
  final Widget gotoscreen;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => gotoscreen,
            ),
          );
        },
        child: Container(
          height: 100,
          color: colors,
          child: Center(
            child: Text(
              myTitle,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class SeeAll extends StatelessWidget {
  const SeeAll({
    this.seeAllText,
    Key key,
  }) : super(key: key);

  final String seeAllText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            seeAllText,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "شاهد الكل ->",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
