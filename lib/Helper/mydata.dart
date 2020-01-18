// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}

/*
List mysalamList=
[
  {'profileName': 'سلام', 'Type': 'since', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1'], 'Time': 2019-12-16, 'title': 'alibaba', 'ImagesTitles': [ 'imgTitle1']},

  {'profileName': 'Hayder', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'hayderabudm', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'محمد', 'Type': 'bio', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'فؤاد', 'Type': 'since', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'fouad', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'هادي', 'Type': 'since', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'سعد', 'Type': 'bio', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'نور', 'Type': 'maha', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'ليلى', 'Type': 'school', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'محمد', 'Type': 'maha', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},
  {'profileName': 'محمد', 'Type': 'since', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1'], 'Time': 2019-12-16, 'title': 'alibaba', 'ImagesTitles': [ 'imgTitle1']},

  {'profileName': 'Hayder', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'hayderabudm', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'محمد', 'Type': 'bio', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'rabab', 'Type': 'since', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'fouad', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'rabab', 'Type': 'since', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'سعد', 'Type': 'bio', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'صالح', 'Type': 'maha', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'ليلى', 'Type': 'school', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'حسن', 'Type': 'maha', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'فؤاد', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'صالح', 'Type': 'school', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'سعد', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'حسين', 'Type': 'maha', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'ليلى', 'Type': 'school', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'عبد الله', 'Type': 'maha', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'فؤاد', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'صالح', 'Type': 'school', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

  {'profileName': 'سعد', 'Type': 'kid', 'pages': 120, 'pris': 25, 'ImageUrl': ['imgUrl1','imgUrl2'], 'Time': 2019-12-16, 'title': 'itemtitle', 'ImagesTitles': [ 'imgTitle1','imgTitle2']},

];

 */
