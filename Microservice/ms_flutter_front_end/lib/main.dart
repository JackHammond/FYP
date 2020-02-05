import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';

void main() {
  runApp(
    MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false,),
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
  List basketData;
  var rating = 0.0;
  List<String> basketItems = List<String>();
  String basketID;
  final String userID = "5e2c8c86e5413e350c164d26";

  getProducts() async {
    http.Response response =
        await http.get('http://35.242.134.188:8762/catalog/');
    data = json.decode(response.body);
    setState(() {
      productData = data['products'];
    });
  }

  getBasket() async {
    http.Response response =
        await http.get('http://35.242.134.188:8762/basket/');
    data = json.decode(response.body);
    setState(() {
      basketData = data['baskets'];
      basketID = basketData[0]["_id"];
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    getBasket();
  }

  addOrDelete(String productID) {
    if (basketID == null) {
      createBasket(userID, productID);
    } else {
      updateBasket(basketID, productID);
      print("BasketID: " + basketID);
    }
  }

  createBasket(String userID, String productID) async {
    basketItems.add(productID);
    http.Response response = await http
        .post('http://35.242.134.188:8762/basket/create', body: {
      "user_ID": userID,
      "savedProduct_IDs": json.encode(basketItems)
    });
    getBasket();
  }

  updateBasket(String basketID, String productID) async {
    basketItems.add(productID);
    print(basketItems.toString());
    http.Response response = await http.put(
        'http://35.242.134.188:8762/basket/update',
        body: {"_id": basketID, "savedProduct_IDs": json.encode(basketItems)});
    getBasket();
  }

  removeBasketItem(String productID) async {
    if (productID != null) {
      print("Removed: " + productID.toString());
      basketItems.remove(productID);
    }
    print("Updated Basket: " + basketItems.toString());
    http.Response response = await http.put(
        'http://35.242.134.188:8762/basket/update',
        body: {"_id": basketID, "savedProduct_IDs": json.encode(basketItems)});
    getBasket();
  }

  getAverageRating(String productID) async {
    http.Response response = await http.put(
        "http://35.242.134.188:8762/review/average",
        body: {"_id": productID});
    print(response.body);
  }

  createRating(String productID, String rating) async {
    await http.post('http://35.242.134.188:8762/review/create',
        body: {"_id": productID, "productRating": rating});
    print(productID + " Review created");
    //re calculate average for the product
    getAverageRating(productID);
    //return updated products
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Catalog"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              icon: Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
              onPressed: () async {
                //pass product values and return selected productID for removal 
                var productID = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BasketPage(
                            basket: basketData,
                            catalog: productData,
                            list: basketItems,
                            userid: userID,
                          )),
                );
                removeBasketItem(productID);
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productData == null ? 0 : productData.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
            child: Card(
              child: Column(children: <Widget>[
                ListTile(
                  subtitle: Text("${productData[index]["productDepartment"]}"),
                  title: Text(
                    "${productData[index]["productName"]}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  trailing: Text(
                    productData[index]["productRating"] + "/5",
                    style: TextStyle(fontSize: 20, wordSpacing: 1),
                  ),
                ),
                ListTile(
                  leading: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {
                            rating = v;
                            createRating(productData[index]["_id"].toString(),
                                rating.toString());
                            print(rating);
                            //setState(() {});
                          },
                          starCount: 5,
                          rating:
                              double.parse(productData[index]["productRating"]),
                          size: 40.0,
                          color: Colors.green,
                          borderColor: Colors.green,
                          spacing: 0.0),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 15),
                        child: Text("£${productData[index]["productPrice"]}", style: TextStyle(fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: IconButton(
                            onPressed: () =>
                                addOrDelete(productData[index]["_id"].toString()),
                            icon: Icon(
                              Icons.shopping_basket,
                              color: Colors.green,
                            )),
                      )
                    ],
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}

class BasketPage extends StatefulWidget {
  final List basket;
  final List catalog;
  final List list;

  final String userid;
  BasketPage(
      {Key key,
      @required this.basket,
      @required this.catalog,
      @required this.userid,
      @required this.list})
      : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  double totalValue;
  List<String> tags = List<String>();

  _decodeBasket() {
    if(widget.basket[0]["savedProduct_IDs"].toString()!= null){
    String recievedJson = widget.basket[0]["savedProduct_IDs"].toString();
    var tagsJson = jsonDecode(recievedJson);
    tags = tagsJson != null ? List.from(tagsJson) : null;
    }
  }

  _totalBasket() async {
    http.Response response = await http.put(
        'http://35.242.134.188:8762/basket/total',
        body: {"user_ID": widget.userid});
    totalValue = double.parse(response.body);
    //print(response.body);
    setState(() => totalValue = double.parse(response.body));
  }

  _getBasketItem(int index) {
    for (int i = 0; i < widget.catalog.length; i++) {
      if (tags.contains(widget.catalog[i]["_id"])) {
        if (tags[index] == widget.catalog[i]["_id"]) {
          return widget.catalog[i]["productName"].toString();
        }
      }
    }
  }

  _getBasketPrice(int index) {
    for (int i = 0; i < widget.catalog.length; i++) {
      if (tags.contains(widget.catalog[i]["_id"])) {
        if (tags[index] == widget.catalog[i]["_id"]) {
          String price = widget.catalog[i]["productPrice"].toString();
          return double.parse(price);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _totalBasket();
    _decodeBasket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basket"),
      ),
      body: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
            child: Card(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {
                          Navigator.pop(context, tags[index].toString());
                        },
                        iconSize: 30,
                      ),
                      Text(
                        _getBasketItem(index),
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                  trailing: Text("£" + _getBasketPrice(index).toString(),
                      style: TextStyle(fontSize: 16.0)),
                )
              ],
            )),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Total: £" + totalValue.toString(),
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
