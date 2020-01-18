import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ParsingData extends StatelessWidget {
  
   
  final List mysetList;

  
  

ParsingData( this.mysetList);



  @override
  Widget build(BuildContext context) {
List<ExpansionTile> myListTitle;

 myListTitle = this.mysetList
        .map((data) => ExpansionTile(
            title: Text(data[0].toString()), children: listWidget(data: data)))
                    .toList();
            
                return Scaffold(
                    appBar: AppBar(
                      title: Text('Expandable ListView Example'),
                    ),
                    body: ListView(children: myListTitle));
            
              }
            }
            
            List<Widget> listWidget({List data}) 
            {
    List<Widget> myList = [];
    //List<dynamic> myHani=data.removeAt(0);

    data.forEach((f) {
      if (f is Map<String, dynamic>) if (f['ImagesTitles'].length == 1)
        myList.add(Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(f['ImagesTitles'][0].toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                )),
            Image.network(
              f['ImageUrl'][0].toString(),
              width: 150,
            ),
          ],
        ));
      else {
        Map<String, dynamic> salam = f;
        salam.forEach((i, d) {
          //print(d.runtimeType);
          if (i == 'ImagesTitles') {
            List m = d.toList();
            m.forEach((g) {
              myList.add(Text(g.toString()));
            });
          }
          if (i == 'ImageUrl' ) {
            List<Widget> mdd = [];
            List m = d.toList();
            m.forEach((g) {
              mdd.add(
                
               CachedNetworkImage(
        imageUrl: g.toString(),
        placeholder: (context, url) => Image.asset('assets/loading.gif'),
        errorWidget: (context, url, error) => Icon(Icons.error),
        width: 100,
     ),
              
              );
            });

            myList.add(
              Wrap(children: mdd),
            );
          }
        });
      }
    });

    return myList;
  }