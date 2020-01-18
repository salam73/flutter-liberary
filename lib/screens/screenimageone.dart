import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScreenImageOne extends StatefulWidget {
  ScreenImageOne({Key key}) : super(key: key);

  @override
  _ScreenImageOneState createState() => _ScreenImageOneState();
}

class _ScreenImageOneState extends State<ScreenImageOne> {
  @override
  Widget build(BuildContext context) {
    return Container(

       child: 
       CachedNetworkImage(
        imageUrl: "https://wallpaperaccess.com//full/155603.jpg",
        placeholder: (context, url) => Image.asset('assets/loading.gif'),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
       
     //  Image.network('https://wallpaperaccess.com//full/155603.jpg'),
    
    );
  }
}