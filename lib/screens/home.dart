import 'package:bookhouse2/screens/not_update.dart';
import 'package:bookhouse2/screens/home_screen.dart';
import 'package:bookhouse2/screens/search_screen.dart';
import 'package:bookhouse2/service/fetch_data.dart';
import 'package:bookhouse2/service/firebase_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'intro.dart';
import 'type_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class Home extends StatefulWidget {
  @override
  Iterable<T> merge<T>(Iterable<T> c1, Iterable<T> c2) sync* {
    var it1 = c1.iterator;
    var it2 = c2.iterator;
    var active = true;
    while (active) {
      active = false;
      if (it1.moveNext()) {
        active = true;
        yield it1.current;
      }

      if (it2.moveNext()) {
        active = true;
        yield it2.current;
      }
    }
  }

  List<Widget> listToImags(DocumentSnapshot doc) {
    List<Widget> images = [];
    List<Widget> imagesTitles = [];
    List<Widget> images3 = [];
    List<String> listImagesTitles = [];
    List<String> listImageUrl = [];
    List<String> images4 = [];

    // List myListing = doc['ImageUrl'] as List;

//    doc.data.forEach((index, value) {
//      //   print (value);
//
//      if (value is List) {
//        // print(doc['title']);
//      }
//  عل
//      //  print (doc['ImagesTitles'][index])
//    });

    Map<String, dynamic> multilistItem = doc.data;

    multilistItem.forEach((key, item) {
      if (key == 'ImageUrl') {
        List m = item.toList();

        m.forEach((url) {
          Widget imgUrl = FractionallySizedBox(
            widthFactor: 0.4,
            child: GestureDetector(
              onTap: () {
                print(url);
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: (Image.network(
                  url,
                )),
              ),
            ),
          );

          images.add(imgUrl);
          listImagesTitles.add(url);
        });
      }


      
    });

    for (String url in doc['ImagesTitles']) {
      Widget imgTitle = RotatedBox(
        quarterTurns: -1,
        child: Container(
          width:130,
          child: Text(
            url, //(url)  مهم تذكر هذا الشيء واستخدام ما بين القوسين
           // textDirection: TextDirection.rtl,
           textAlign: TextAlign.center,
          ),
        ),
      );
      imagesTitles.add(imgTitle);
      listImageUrl.add(url);
    }

    images3 = merge(images, imagesTitles).toList();
    images4 = merge(listImagesTitles, listImageUrl).toList();
//images3=Column(children: images3,) as List<Widget>;

    return images3;
  }

  Column listofColumn(doc) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
              //  'العنوان:${doc['title']}',
              doc['title'],
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
               // 'الكاتب :${doc['profileName']}',
               doc['profileName'],
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
        Container(
          //  color: Colors.black12,
            // alignment: Alignment.topLeft,

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Text('الكتاب يوجد في سلسلة'),
                  ),
                 
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: listToImags(doc),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Column listofColumnWinthouImage(doc) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'العنوان:${doc['title']}',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'الكاتب :${doc['profileName']}',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
        /*  Container(
          color: Colors.black12,
            // alignment: Alignment.topLeft,

            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: listToImags(doc),
          ),
        )) */
      ],
    );
  }

  bool _getQuery({List imageTitles, String profileTitles, String myQuery}) {
    bool _queryResult =
        imageTitles.any((a) => a.toString().contains(myQuery)) ||
            profileTitles.contains(myQuery);
    return _queryResult;
  }

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataList = [];
  List sortTypeArray = [];
  List typeItemArray = [];
  List widgetItemArray = [];
  List mySetList = [];
  List mySetListTitle = [];
  List<Widget> myList;

  List<ExpansionTile> myListTitle;

  // bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  String _title = 'رئيسية';

  getFirebaseData() async {
    final QuerySnapshot snapshot = await usersRef
        //  .where("Type", isEqualTo: "اطفال")
        .orderBy('Type')
        .getDocuments();

    setState(() {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        dataList.add(doc.data);
        print(doc.data);
      });
    });

    /*  dataList.forEach((m) => {sortTypeArray.add(m['Type'])});

    sortTypeArray =
        sortTypeArray.toSet().toList(); //remove duplicate items of list
    //print(sortTypeArray);

    sortTypeArray.forEach((m) {
      typeItemArray.add(m.toString());

      dataList.forEach((f) {
        if (f['Type'] == m) {
          //  print(   mysalamList.every((f)=>f['Type'] == m));

          typeItemArray.add(f);
        } else {
          return;
        }
        widgetItemArray.add(typeItemArray);
      });
      typeItemArray = [];
    });
    // print(widgetItemArray.toSet());

    mysetList = widgetItemArray.toSet().toList(); */
  }

  @override
  void initState() {
    super.initState();

    getFirebaseData();

    pageController = PageController();
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;

      switch (pageIndex) {
        case 0:
          {
            _title = 'رئيسية';
          }
          break;
        case 1:
          {
            _title = 'أقسام';
          }
          break;
        case 2:
          {
            _title = 'ترتيب';
          }
          break;
        case 3:
          {
            _title = 'بحث';
          }
          break;
      }
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,
      appBar: AppBar(
        //  backgroundColor: Color(0xff42aaff),
        title: Text(_title, style: GoogleFonts.almarai(fontSize: 16)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBook());
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'المكتبة',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('عن المكتبة'),
              onTap: () {},
            ),
            ListTile(
              title: Text('العنوان'),
              onTap: () {},
            ),
            ListTile(
              title: Text('الأقسام'),
              onTap: () {},
            ),
            ListTile(
              title: Text('اتصل بنا'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            //  Timeline(),
            //  Splashscreen(),
            //Search(),
            //Splash(),
            //SplashScreen(),

            TypeScreen(
              dbList: dataList,
            ),
            FireBaseData(
              dbList: dataList,
            ),

            ExpandableListView(),

            IntroScreen(
              dbList: dataList,
            ),
            //SliderShow(dbList: dataList,),

            SearchScreen(),

            // ExpansionTileSample(),

            //ParsingData(mysetList),
            //ScreenImageOne(),

            // Headerbar(),

            HomeScreen(),

            // MyListview(),

            // IntroScreen(),

            FetchData(),
          ],
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('رئيسية'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_style),
            title: Text('أقسام'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            title: Text('ترتيب'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('بحث'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attachment),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
          ),
        ],
      ),
    );
  }
}

class SearchBook extends SearchDelegate<Widget> {
  Home myClassReference = Home();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Waiting'),
            );
          }

          //final resualt= usersRef.snapshots().data.where((a) => a.title.toLowerCase().contains('f'));

          final List<Column> children = snapshot.data.documents
              .where((a) => (a['ImagesTitles'].toList().length > 1)
                  ? myClassReference._getQuery(
                      imageTitles: a['ImagesTitles'],
                      profileTitles: a['profileName'],
                      myQuery: query)
                  : a['ImagesTitles'][0].toString().contains(query) ||
                      a['profileName'].contains(query) ||
                      a['title'].contains(query))
              .map(
                (doc) => myClassReference.listofColumn(doc),
              )
              .toList();

          return ListView(
            children: children,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return (Text('Waiting'));
          }

          //final resualt= usersRef.snapshots().data.where((a) => a.title.toLowerCase().contains('f'));
          final List<Column> children = snapshot.data.documents
              .where((a) => (a['ImagesTitles'].toList().length > 1)
                  ? myClassReference._getQuery(
                      imageTitles: a['ImagesTitles'],
                      profileTitles: a['profileName'],
                      myQuery: query)
                  : a['ImagesTitles'][0].toString().contains(query) ||
                      a['profileName'].contains(query) ||
                      a['title'].contains(query))
              .map(
                (doc) => myClassReference.listofColumnWinthouImage(doc),
              )
              .toList();
          if (query.length > 0)
            return ListView(
              children: children,
            );
          return Center(
            child: Text(
              'اكتب اسم الكتاب أو اسم المؤالف',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.start,
            ),
          );
        });
  }

  @override
  String get searchFieldLabel => "إكتب عنوان الكتاب أو اسم المؤلف";
}

//My name is
