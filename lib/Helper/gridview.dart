import 'package:flutter/material.dart';


class MyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 300),
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio:2.30,

        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(6, (index) {
          return Container(
            color: Colors.deepPurple[300],
            child: Text(
              'Book $index',

            ),
          );
        }),
      ),
    );
  }
}