import 'package:bookhouse2/screens/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final usersRef = Firestore.instance.collection('library');

List<Widget> wrapTextImage = [];
List<Widget> wrapImageWidget = [];

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

List child2 = [];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class ExpandableListView extends StatefulWidget {
  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  List FB_dataList = [];
  List sortTypeArray = [];
  List typeItemArray = [];
  List widgetItemArray = [];
  List setList = [];
  List setListTitle = [];
  List<Widget> onelistItem;

  List<ExpansionTile> _WidgetExpansionTile;

  loadingData() async {
//print(itemsTypeArray);

    final QuerySnapshot snapshot = await usersRef
    //  .where("Type", isEqualTo: "اطفال")
        .orderBy('Type')
        .getDocuments();

    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        FB_dataList.add(doc.data);
      });
    });

    FB_dataList.forEach((m) => {sortTypeArray.add(m['Type'])});

    sortTypeArray =
        sortTypeArray.toSet().toList(); //remove duplicate items of list
    //print(sortTypeArray);

    sortTypeArray.forEach((m) {
      typeItemArray.add(m.toString());

      FB_dataList.forEach((f) {
        if (f['Type'] == m) {
          typeItemArray.add(f);
        } else {
          return;
        }
        widgetItemArray.add(typeItemArray);
      });
      typeItemArray = [];
    });
    // print(widgetItemArray.toSet());

    setList = widgetItemArray.toSet().toList();
  }

  @override
  void initState() {
    loadingData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  List<Widget> listWidget({List data, String title}) {
    onelistItem = [];

    List<Widget> wrapTextWidget = [];

    List<Widget> wrapListImageWidget = [];
    List<Widget> wrapListImageWidgetColumn = [];
    //List<dynamic> myHani=data.removeAt(0);
    List<String> childitem = [];
    List<dynamic> childitem2 = [];

    data.forEach((f) {
      if (f is Map<String, dynamic>) if (f['ImagesTitles'].length ==
          1) //loop for oneitem list
        onelistItem.add(Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: f['ImageUrl'][0].toString(),
              placeholder: (context, url) => Image.asset('assets/loading.gif'),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                f['ImagesTitles'][0].toString(),
                style: TextStyle(
                  fontSize: 25,
                  //color: Colors.red,
                ),
                // textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ));
      else {
        Map<String, dynamic> multilistItem = f;

        multilistItem.forEach((i, item) //loop for multiitem list
        {
          //print(d.runtimeType);
          if (i == 'ImagesTitles') {
            List m = item.toList();
            m.forEach((g) {
              wrapTextWidget.add(
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    g.toString(),
                    textAlign: TextAlign.center,
                    // style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            });

            //WrapTextImage.add(Text())
          }
          if (i == 'ImageUrl') {
            List m = item.toList();

            m.forEach((g) {
              wrapImageWidget.add(CachedNetworkImage(
                imageUrl: g.toString(),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 150,
              ));

              childitem.add(g);
            });
          }
        });
        childitem2.addAll(childitem);

        wrapTextImage = merge(wrapTextWidget, wrapImageWidget).toList();

        wrapListImageWidget.add(
          Container(
            height: 150,
            // color: Colors.deepPurple,

            /* child: CarouselSlider(
              autoPlay: false,
                height: 400.0,
                items: wrapImageWidget),*/

            child: ListView(
                scrollDirection: Axis.horizontal, children: wrapTextImage),
          ),
        );
        wrapImageWidget = [];
        wrapTextWidget = [];
        //wrapListImageWidget=[];

      }

      child2 = map<Widget>(
        childitem2,
            (index, i) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(children: <Widget>[
                Image.network(i, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ).toList();

//
    });

    wrapListImageWidget.forEach((f) => {wrapListImageWidgetColumn.add(f)});

    // wrapTextImage.add(Column(children: wrapTextImage));

    //ExpansionTile(title: Text('سلسلة كتب '+ title), children: wrapTextImage);
    // if (wrapTextImage.length > 1)
    onelistItem.add(

      // very important to make subExpansionTile
      /* ExpansionTile(title: Text('سلسلة كتب ' + title), children: <Widget>[
              Container(
                height: 150 * wrapListImageWidget.length.toDouble(),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //scrollDirection: Axis.horizontal,
                  children: wrapListImageWidgetColumn,
                ),
              )
            ])*/
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    'كتب',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'المزيد',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),

            // wrapListImageWidgetColumn
            Column(
              children: wrapListImageWidgetColumn,
            )
          ],

          // children: wrapListImageWidgetColumn,
        ));

    return onelistItem;
  }

  @override
  Widget build(BuildContext context) {
    //if (myListTitle.length < 1)
    _WidgetExpansionTile = setList
        .map(
          (data) => ExpansionTile(
        title: Text(data[0].toString()),
        children: listWidget(data: data, title: data[0].toString()),
      ),
    )
        .toList();

    return Column(
      children: <Widget>[
        Expanded(
          //flex: 1,
          child: ListView(children: <Widget>[
            //   SliderShow(),
            Column(
              children: <Widget>[
                Text('Hello'),
                Column(
                  children: _WidgetExpansionTile,
                ),
              ],
            )
          ]),
        ),
      ],
    );

    /*  CarouselSlider(
                height: 400.0,
                items: _WidgetExpansionTile

            ));*/
  }
}