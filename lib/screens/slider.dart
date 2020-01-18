import 'package:bookhouse2/service/getfbd.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List image = [
  'https://www.e7kky.com/uploads/1499614030.jpg',
  'https://cdn.sotor.com/thumbs/fit630x300/38537/1560673535/%D9%83%D8%AA%D8%A8_%D8%A7%D9%84%D8%A3%D8%AF%D8%A8_%D8%A7%D9%84%D8%B9%D8%B1%D8%A8%D9%8A_%D8%A7%D9%84%D8%AD%D8%AF%D9%8A%D8%AB.jpg',
  'https://vid.alarabiya.net/images/2017/05/12/f9f1f311-2f33-4398-8caf-a172be66fe85/f9f1f311-2f33-4398-8caf-a172be66fe85_16x9_1200x676.jpg?format=jpeg&width=960',
  'https://www.sayidaty.net/sites/default/files/styles/800x510/public/2019/08/05/5653361-1337794268.jpg',
];
final usersRef = Firestore.instance.collection('library');
List<Widget> child2 = [];

class SliderShow extends StatefulWidget {
  final List dbList;

  const SliderShow({Key key, this.dbList}) : super(key: key);

  @override
  _SliderShowState createState() => _SliderShowState();
}

class _SliderShowState extends State<SliderShow> {
//GetFBD getFBD= GetFBD().getData() as GetFBD;

  List sortTypeArray = [];
  List typeItemArray = [];
  List widgetItemArray = [];
  List setList = [];
  List setListTitle = [];

//GetFBD getFBD= GetFBD();

  var today = new DateTime.now();
  //var fiftyDaysFromNow = today.subtract(new Duration(days: 2));

  loadingData(List dataList) {
    dataList.forEach((m) => {sortTypeArray.add(m['ImageUrl'])});
    sortTypeArray.forEach((f) => {
          f.forEach((d) => {setListTitle.add(d)})
        });
    child2 = map<Widget>(
      setListTitle,
      (index, i) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(children: <Widget>[
              CachedNetworkImage(
                imageUrl: i,
                fit: BoxFit.fill,
                width: 1200,
                placeholder: (context, url) =>
                    Image.asset('assets/loading.gif'),
              ),

              //Image.network(i, fit: BoxFit.fill, width: 1200.0),
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
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
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
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadingData(widget.dbList);

    return CarouselSlider(
      items: child2,
      autoPlay: true,
      //enlargeCenterPage: true,
      viewportFraction: 0.5,
      aspectRatio: 2,
    );
  }
}
