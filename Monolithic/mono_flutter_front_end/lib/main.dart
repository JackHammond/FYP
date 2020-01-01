import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List productData;
  var rating = 0.0;
  Widget _ratingsIndicator() {
    return Center(
      child: RatingBarIndicator(
        rating: 2.75,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 25.0,
        direction: Axis.horizontal,
      ),
    );
  }

  Widget _ratingsBar(index) {
    return SmoothStarRating(
        allowHalfRating: false,
        onRatingChanged: (v) {
          rating = v;
          setState(() {});
          updateRating(productData[index]["_id"].toString(), rating.toString());
        },
        starCount: 5,
        rating: rating,
        size: 30.0,
        color: Colors.green,
        borderColor: Colors.green,
        spacing: 0.0);
  }

  getProducts() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/catalog');
    data = json.decode(response.body);
    setState(() {
      productData = data['products'];
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  updateRating(String uid, String rating) async {
    http.Response response = await http.put(
        'http://10.0.2.2:4000/api/catalog/rating',
        body: {"_id": uid, "productRating": rating});
    print(uid + " UID");
    print(rating + " Rating");
    print(response);
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Catalog"),
      ),
      body: ListView.builder(
        itemCount: productData == null ? 0 : productData.length,
        itemBuilder: (context, int index) {
          return Card(
            child: Column(children: <Widget>[
              ListTile(
                title: Text(
                  "${productData[index]["productName"]}",
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: Text(
                    "Rating: ${productData[index]["productRating"]}" + "/5.0"),
              ),
              ListTile(
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 20,
                        height: 50.0,
                        child: GestureDetector(
                          onTap: () => updateRating(
                              productData[index]["_id"].toString(), "1"),
                          child: Container(
                              color: Colors.green,
                              child: Center(child: Text("1"))),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          height: 50.0,
                          child: GestureDetector(
                            onTap: () => updateRating(
                                productData[index]["_id"].toString(), "2"),
                            child: Container(
                                color: Colors.green,
                                child: Center(child: Text("2"))),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          height: 50.0,
                          child: GestureDetector(
                            onTap: () => updateRating(
                                productData[index]["_id"].toString(), "3"),
                            child: Container(
                                color: Colors.green,
                                child: Center(child: Text("3"))),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          height: 50.0,
                          child: GestureDetector(
                            onTap: () => updateRating(
                                productData[index]["_id"].toString(), "4"),
                            child: Container(
                                color: Colors.green,
                                child: Center(child: Text("4"))),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          height: 50.0,
                          child: GestureDetector(
                            onTap: () => updateRating(
                                productData[index]["_id"].toString(), "5"),
                            child: Container(
                                color: Colors.green,
                                child: Center(child: Text("5"))),
                          ),
                        )),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("£${productData[index]["productPrice"]}"),
                    IconButton(
                        onPressed: () {
                          //add to basket list
                        },
                        icon: Icon(
                          Icons.shopping_basket,
                          color: Colors.green,
                        ))
                  ],
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
