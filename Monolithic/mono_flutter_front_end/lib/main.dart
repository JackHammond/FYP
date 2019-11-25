import 'dart:convert';

import 'package:flutter/material.dart';

import 'API.dart';
import 'Catalog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Monolith',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State {
  var catalog = new List<Catalog>();
  var _saved = new Set<Catalog>();

  _getProducts() {
    API.getProducts().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        catalog = list.map((model) => Catalog.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getProducts();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Hero Animation Demo'),
      ),
      body: _buildCatalog(),
    ));
  }

// void _addToBasket() {
//   Navigator.of(context).push(
//     MaterialPageRoute<void>(
//       builder: (BuildContext context) {
//         final Iterable<ListTile> tiles = _saved.map(
//           (Catalog catalog) {
//             return ListTile(
//               title: Text(
//                 catalog.name,
//               ),
//             );
//           },
//         );
//         final List<Widget> divided = ListTile.divideTiles(
//           context: context,
//           tiles: tiles,
//         ).toList();

//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Basket'),
//           ),
//           body: ListView(children: divided),
//         );
//       },
//     ),
//   );
// }

  _buildCatalog() {
    return ListView.builder(
      itemCount: catalog.length,
      itemBuilder: (context, index) {
        return Container(
          child: ,
        );
      },
    );
  }

  ListTile _buildRow(int index, BuildContext context) {
    //final bool alreadySaved = _saved.contains(catalog[index]);
    return ListTile(
      title: Text(catalog[index].name),
      //trailing: Icon(
      //  alreadySaved ? Icons.favorite : Icons.favorite_border,
        //color: alreadySaved ? Colors.red : null,
      //),
      //leading: CircleAvatar(backgroundImage: NetworkImage(catalog[index].url)),
      leading: Text(catalog[index].price),
      onTap: () {
        // setState(() {
        //   if (alreadySaved) {
        //     _saved.remove(catalog[index]);
        //   } else {
        //     _saved.add(catalog[index]);
        //   }
        // });
      },
    );
  }
}
