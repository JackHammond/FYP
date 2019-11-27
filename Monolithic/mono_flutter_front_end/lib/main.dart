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
  final Set<Catalog> _saved = Set<Catalog>();

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
        final bool alreadySaved = widget._saved.contains(widget.catalog[index]);
        return Column(
          children: <Widget>[
            RaisedButton(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Text(widget.catalog[index].color)),
                    Icon(
                      alreadySaved ? Icons.favorite : Icons.favorite_border,
                      color: alreadySaved ? Colors.red : null,
                    ),
                  ]),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProductDetail(
                //       catalog: widget.catalog[index],
                //     ),
                //   ),
                // );
                setState(() {
                  if (alreadySaved) {
                    print(widget.catalog[index]);
                    widget._saved.remove(widget.catalog[index]);
                  } else {
                    print(widget.catalog[index].id);

                    widget._saved.add(widget.catalog[index]);
                  }
                });
              },
            ),
          ],
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
