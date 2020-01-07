import 'package:bookhouse2/screens/MyListView.dart';
import 'package:bookhouse2/screens/NotUpdate.dart';
import 'package:bookhouse2/screens/homescreen.dart';
import 'package:bookhouse2/screens/searchscreen.dart';
import 'package:bookhouse2/service/fetchdata.dart';
import 'package:bookhouse2/service/firebasedata.dart';

import 'typescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
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
          // physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            //  Timeline(),
            //  Splashscreen(),
            //Search(),
            //Splash(),
            //SplashScreen(),

           ExpandableListView(),

            Tyepscreen(),
            FireBaseData(),

            // Headerbar(),

            SearchScreen(),

            HomeScreen(),

            MyListview(),

            FetchData(),

            //FetchData()

            // FetchData(),
          ],
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.hot_tub),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            icon: Center(child: Icon(Icons.search)),
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
