import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  final Color backgroundColor;
  final String headerTitle;
  final List<Widget> myList;

  HeaderBar(this.backgroundColor, this.headerTitle, this.myList);
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(backgroundColor, headerTitle, myList),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String headerTitle;
  final List<Widget> myList;

  Delegate(this.backgroundColor, this.headerTitle, this.myList);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: myList,
    );
  }

  @override
  double get maxExtent => 560;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
