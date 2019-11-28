import 'package:example/Catalog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'API.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      theme: ThemeData.dark(),
      home: FutureBuilder<List<Catalog>>(
        future: API.fetchCatalog(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RandomWords(suggestions: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  // #enddocregion build
}
// #enddocregion MyApp

class RandomWords extends StatefulWidget {
  final List<Catalog> suggestions;
  RandomWords({Key key, @required this.suggestions}) : super(key: key);
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final Set<Catalog> _saved = Set<Catalog>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        itemCount: widget.suggestions.length,
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(widget.suggestions[i]);
        });
  }

  Widget _ratingsIndicator() {
    return Center(
      child: FlutterRatingBarIndicator(
        rating: 2.55,
        itemCount: 5,
        itemSize: 20.0,
        emptyColor: Colors.amber.withAlpha(50),
      ),
    );
  }

  Widget _buildRow(Catalog pair) {
    final bool alreadySaved = _saved.contains(pair);
    return Card(
      margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
                pair.title,
                style: _biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(pair);
                  } else {
                    _saved.add(pair);
                  }
                });
              }),
          ListTile(
            leading: Text(pair.price),
            trailing: Icon(
              alreadySaved ? Icons.shopping_basket : Icons.shopping_basket,
              color: alreadySaved ? Colors.green : null,
            ),
            subtitle: _ratingsIndicator(),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(pair);
                } else {
                  _saved.add(pair);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: _buildSuggestions());
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (Catalog pair) {
              return ListTile(
                title: Text(
                  pair.title,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
