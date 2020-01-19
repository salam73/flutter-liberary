import 'package:bookhouse2/screens/not_update.dart';
import 'package:bookhouse2/screens/home_screen.dart';
import 'package:bookhouse2/screens/search_screen.dart';
import 'package:bookhouse2/service/fetch_data.dart';
import 'package:bookhouse2/service/firebase_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'intro.dart';
import 'type_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('library');

class Home extends StatefulWidget {
  @override
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

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        dataList.add(doc.data);
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
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
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
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('العنوان'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('الأقسام'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('اتصل بنا'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
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
            Tyepscreen(dbList: dataList),
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
              icon: Icon(Icons.home), title: Text('رئيسية')),
          BottomNavigationBarItem(
              icon: Icon(Icons.line_style), title: Text('أقسام')),
          BottomNavigationBarItem(
              icon: Icon(Icons.layers), title: Text('ترتيب')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('بحث')),
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
//My name is
