import 'package:bookhouse2/Helper/mydata.dart';
import 'package:bookhouse2/screens/MyListView.dart';
import 'package:bookhouse2/screens/NotUpdate.dart';
import 'package:bookhouse2/screens/homescreen.dart';
import 'package:bookhouse2/screens/parsingdata.dart';
import 'package:bookhouse2/screens/screenimageone.dart';
import 'package:bookhouse2/screens/searchscreen.dart';
import 'package:bookhouse2/service/fetchdata.dart';
import 'package:bookhouse2/service/firebasedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'intro.dart';
import 'typescreen.dart';
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
  List mysetList = [];
  List mysetListTitle = [];
  List<Widget> myList;

  List<ExpansionTile> myListTitle;

  // bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

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

    dataList.forEach((m) => {sortTypeArray.add(m['Type'])});

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

    mysetList = widgetItemArray.toSet().toList();
  }

  @override
  void initState() {
    super.initState();

//if(mounted)
    getFirebaseData();

    pageController = PageController(
        //initialPage: pageIndex
        );
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Widget build(BuildContext context) {
    return Scaffold(
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

            FireBaseData(),


            ExpandableListView(),

            Tyepscreen(),
            SearchScreen(),
            // ExpansionTileSample(),

            //ParsingData(mysetList),
            //ScreenImageOne(),



            // Headerbar(),



            HomeScreen(),

            MyListview(),

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
