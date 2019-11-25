import "package:flutter/material.dart";
import 'SelectedProductDetail.dart';
import 'Catalog.dart';
class User extends StatelessWidget {
  final Catalog catalog;

  User(this.catalog);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetail(catalog))),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Hero(
              tag: "product_" + catalog.id.toString(),
              child: Center(
                  child: Text(catalog.department.toString()),
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(catalog.name),
            )
          ],
        ),
      ),
    );
  }
}
