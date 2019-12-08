import 'package:bookhouse2/screens/MyListView.dart';
import 'package:bookhouse2/screens/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;


  @override


  void initState() {
    super.initState();
    pageController = PageController(
      //initialPage: pageIndex
    );
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
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          //  Timeline(),
          Search(),
          MyListview(),







        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
