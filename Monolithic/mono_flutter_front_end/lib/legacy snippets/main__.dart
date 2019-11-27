// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'API.dart';
// import 'Catalog.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   build(context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'The Monolith',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomeScreen(),
//     );
//   }
// }

// class MyHomeScreen extends StatefulWidget {
//   @override
//   createState() => _MyHomeScreenState();
// }

// class _MyHomeScreenState extends State {
//   var catalog = new List<Catalog>();
//   //var _saved = new Set<Catalog>();

//   _getProducts() {
//     API.getProducts().then((response) {
//       setState(() {
//         Iterable list = json.decode(response.body);
//         catalog = list.map((model) => Catalog.fromJson(model)).toList();
//       });
//     });
//   }

//   initState() {
//     super.initState();
//     _getProducts();
//   }

//   dispose() {
//     super.dispose();
//   }

//   @override
//   build(context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Catalog Items"),
//           actions: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.shopping_basket), onPressed: _addToBasket ),
//           ],
//         ),
//         body: _buildCatalog());
//   }

//   void _addToBasket() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (BuildContext context) {
//           final Iterable<ListTile> tiles = _saved.map(
//             (Catalog catalog) {
//               return ListTile(
//                 title: Text(
//                   catalog.name,
//                 ),
//               );
//             },
//           );
//           final List<Widget> divided = ListTile.divideTiles(
//             context: context,
//             tiles: tiles,
//           ).toList();

//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Basket'),
//             ),
//             body: ListView(children: divided),
//           );
//         },
//       ),
//     );
//   }

// void _selectedProduct() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (BuildContext context) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Product Information'),
//             ),
//             body: Center(
//               child: Hero(
//                 tag: "selectedProduct",
//               //todo: add padding?
//               ),
//             )
//           );
//         },
//       ),
//     );
//   }

//   _buildCatalog() {
//     return ListView.builder(
//       itemCount: catalog.length,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return Container(
//           child: _buildRow(index, context),
//         );
//       },
//     );
//   }

//   ListTile _buildRow(int index, BuildContext context) {
//     final bool alreadySaved = _saved.contains(catalog[index]);
//     return ListTile(
//       title: Text(catalog[index].name),
//       trailing: Icon(
//         alreadySaved ? Icons.favorite : Icons.favorite_border,
//         color: alreadySaved ? Colors.red : null,
//       ),
//       //leading: CircleAvatar(backgroundImage: NetworkImage(catalog[index].url)),
//       leading:
//           Text(catalog[index].price),
//       onTap: () {
//         Hero(
//           tag: "selectedProduct"+ catalog[index].id.toString(),
//           child: GestureDetector(
//             onTap: () => _selectedProduct(),
//           ),
//         );
//         setState(() {
//           if (alreadySaved) {
//             _saved.remove(catalog[index]);
//           } else {
//             _saved.add(catalog[index]);
//           }
//         });
//       },
//     );
//   }

//   // Future _navigateToReviewPage(BuildContext context, int index) {
//   //   return Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //         builder: (context) => Reviews(
//   //               catalog: catalog[index],
//   //             )),
//   //   );
//   // }
// }
