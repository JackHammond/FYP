import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Catalog.dart';
import 'API.dart';

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

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Catalog>>(
        future: API.fetchCatalog(http.Client()),
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

class ProductList extends StatefulWidget {
  final List<Catalog> catalog;

  ProductList({Key key, this.catalog}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.catalog.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
              child: Column(children: <Widget>[
            Center(child: Text(widget.catalog[index].color)),
            RaisedButton(
              child: Text("Test Button"),
              onPressed: _addToBasket(),
            )
          ])),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(
                  catalog: widget.catalog[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
  _addToBasket(){
    
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
