import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Catalog>> fetchProducts(http.Client client) async {
  final response = await client.get('https://api.myjson.com/bins/xutvq');

  // Use the compute function to run parseProducts in a separate isolate.
  return compute(parseProducts, response.body);
}

// A function that converts a response body into a List<Product>.
List<Catalog> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Catalog>((json) => Catalog.fromJson(json)).toList();
}

class Catalog {
  final int id;
  final String title;
  final String department;
  final String color;
  final String price;

  Catalog({this.department, this.id, this.title, this.color, this.price});

  factory Catalog.fromJson(Map<String, dynamic> json) {
    return Catalog(
      department: json['department'] as String ?? 'department is null',
      id: json['id'] as int ?? 'id is null',
      title: json['name'] as String?? 'name is null',
      color: json['color'] as String?? 'color is null',
      price: json['price'] as String?? 'price is null',
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Catalog>>(
        future: fetchProducts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ProductList(catalog: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Catalog> catalog;

  ProductList({Key key, this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: catalog.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Center(child: Text(catalog[index].color)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(
                  catalog: catalog[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Catalog catalog;

  ProductDetail({Key key, @required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catalog.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
            ),
            Text(
              catalog.department,
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
