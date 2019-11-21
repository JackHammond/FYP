import 'package:flutter/material.dart';
import 'package:mono_flutter_front_end/Catalog.dart';

class Reviews extends StatelessWidget {
  final Catalog catalog;
  Reviews({this.catalog});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 54.0,
              padding: EdgeInsets.all(12.0),
              child: Text("Data passed to this page:",
                  style: TextStyle(fontWeight: FontWeight.w700))),
          Text("Text: ${catalog.title}"),
          Text("Counter: ${catalog.id}"),
          CircleAvatar(backgroundImage: NetworkImage(catalog.url)),
        ],
      ),
    );
  }
}
