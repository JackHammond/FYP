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
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Container(
              child: ListTile(
                title: Text(users[index].name),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(catalog[index].url)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reviews()),
                ),
              ),
            );
          },
        ));
  }
}
