import 'dart:convert';

import 'package:flutter/material.dart';

import 'API.dart';
import 'Catalog.dart';
import 'User.dart';
import 'Reviews.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<User>();
  var catalog = new List<Catalog>();
  var _saved = new Set<Catalog>();
  _getCatalog() {
    API.getCatalog().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        catalog = list.map((model) => Catalog.fromJson(model)).toList();
      });
    });
  }

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
    _getCatalog();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Catalog Items"),
          actions: <Widget>[
            // Add 3 lines from here...
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: _buildCatalog());
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (Catalog catalog) {
              return ListTile(
                title: Text(
                  catalog.title,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          ); // ... to here.
        },
      ),
    );
  }

  _buildCatalog() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Container(
          child: _buildRow(index, context),
        );
      },
    );
  }

  ListTile _buildRow(int index, BuildContext context) {
    final bool alreadySaved = _saved.contains(catalog[index]);
    return ListTile(
      title: Text(users[index].name),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      leading: CircleAvatar(backgroundImage: NetworkImage(catalog[index].url)),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(catalog[index]);
          } else {
            _saved.add(catalog[index]);
          }
        });
      },
    );
  }

  Future _navigateToReviewPage(BuildContext context, int index) {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Reviews(
                catalog: catalog[index],
              )),
    );
  }
}
