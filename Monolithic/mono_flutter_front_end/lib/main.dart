import 'dart:convert';

import 'package:flutter/material.dart';
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
  List productReview;
  getProducts() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/catalog');
    data = json.decode(response.body);
    setState(() {
      productData = data['products'];
    });
  }

  getReviews() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/review');
    data = json.decode(response.body);
    setState(() {
      productReview = data['reviews'];
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    getReviews();
  }

  updateRating(String uid, String rating) async {
    http.Response response = await http.post(
        'http://10.0.2.2:4000/api/review/create',
        body: {"_id": uid, "productRating": rating});
    print(uid + " Review ID added");
    print(rating + "Rating added");
    print(response);
    getProducts(); //this will refresh the product catalog list
    getReviews(); //this will refresh the review list
  }

  findAverageRating(String listitem) {
    int ratingCount = 0;
    int matchesCount = 0;
    for (int i = 0; i < productReview.length; i++) {
      if (productReview[i]["product_ID"] == listitem) {
        matchesCount++;
        ratingCount += int.parse(productReview[i]["productRating"]);
      }
    }
    double average = ratingCount / matchesCount;
    if (average.isNaN) {
      average = 0.0;
    }
    String n = average.toStringAsFixed(1);
    return "$n/5.0";
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
                trailing: Text(findAverageRating(productData[index]["_id"])),
                //"Rating: ${productData[index]["productRating"]}" + "/5.0"),
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
