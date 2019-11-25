import "package:flutter/material.dart";
import 'Catalog.dart';

class UserDetail extends StatelessWidget {
  final Catalog catalog;

  UserDetail(this.catalog);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catalog.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Hero(
                tag: "product_" + catalog.id.toString(),
                child: Center(
                  child: Text(catalog.department.toString()),
                ),
              ),
            ),
            Text(
              catalog.name,
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
