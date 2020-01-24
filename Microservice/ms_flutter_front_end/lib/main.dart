import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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
  List basketData;
  List<String> basketItems = List<String>();
  static var uuid = Uuid();
  final String userID = uuid.v1();

  setUserID() {
    var uuid = Uuid();
    return uuid.v1();
  }

  getProducts() async {
    http.Response response =
        await http.get('http://localhost:8762/catalog/');
    data = json.decode(response.body);
    setState(() {
      productData = data['products'];
    });
  }

  getBasket() async {
    http.Response response =
        await http.get('http://localhost:8762/basket/');
    data = json.decode(response.body);
    setState(() {
      basketData = data['baskets'];
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    getBasket();
  }

  addToBasket(String productID) {
    String basketID;
    bool basketExists = false;
    if (basketData.length == null) {
      createBasket(userID, productID);
    }
    for (int i = 0; i < basketData.length; i++) {
      if (basketData[i]["user_ID"] == userID) {
        basketID = basketData[i]["_id"];
        print("Basket Data");
        basketExists = true;
        break;
      } else {
        basketExists = false;
      }
    }
    if (basketExists) {
      updateBasket(basketID, productID);
    } else {
      createBasket(userID, productID);
    }
  }

  createBasket(String userID, String productID) async {
    basketItems.add(productID);
    http.Response response = await http
        .post('http://localhost:8762/basket/create', body: {
      "user_ID": userID,
      "savedProduct_IDs": json.encode(basketItems)
    });
    getBasket();
  }

  updateBasket(String basketID, String productID) async {
    basketItems.add(productID);
    print(basketItems.toString());
    http.Response response = await http.put(
        'http://localhost:8762/basket/update',
        body: {"_id": basketID, "savedProduct_IDs": json.encode(basketItems)});

    getBasket();
  }

  getAverageRating(String listItem) async {
    http.Response response = await http.put(
        "http://localhost:8762/review/average",
        body: {"_id": listItem});
    print(response.body);
  }

  
  // updateBasketAndGetPrice(String userID, String productID) async {
  //   if (basketData.length == null) {
  //     createBasket(userID, productID);
  //   } else {
  //     basketItems.add(productID);
  //     http.Response response = await http
  //         .put('http://localhost:8762/basket/update', body: {
  //       "userID": userID,
  //       "savedProduct_IDs": json.encode(basketItems)
  //     });
  //     //basketPrice = response.body;
  //   }
  //   getBasket();
  // }


  createRating(String productID, String rating) async {
    await http.post('http://localhost:8762/review/create',
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
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.white,
            ),
            onPressed: () async {
              final updatedList = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BasketPage(
                          basket: basketData,
                          catalog: productData,
                          list: basketItems,
                        )),
              );
              String listitems = updatedList != null ? updatedList : "";
              print(listitems + " the removed element");
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productData == null ? 0 : productData.length,
        itemBuilder: (context, int index) {
          //findAverageRating(productData[index]["_id"]);
          return Card(
            child: Column(children: <Widget>[
              ListTile(
                title: Text(
                  "${productData[index]["productName"]}",
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: Text(productData[index]["productRating"] + "/5"),
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
                          onTap: () {
                            createRating(
                                productData[index]["_id"].toString(), "1");
                          },
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
                            onTap: () {
                              createRating(
                                  productData[index]["_id"].toString(), "2");
                            },
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
                            onTap: () {
                              createRating(
                                  productData[index]["_id"].toString(), "3");
                            },
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
                            onTap: () {
                              createRating(
                                  productData[index]["_id"].toString(), "4");
                            },
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
                            onTap: () {
                              createRating(
                                  productData[index]["_id"].toString(), "5");
                            },
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
                        onPressed: () =>
                            addToBasket(productData[index]["_id"].toString()),
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

class BasketPage extends StatelessWidget {
  final List basket;
  final List catalog;
  final List list;
  BasketPage(
      {Key key,
      @required this.basket,
      @required this.catalog,
      @required this.list})
      : super(key: key);

  _decodeBasket() {
    String recievedJson = basket[0]["savedProduct_IDs"].toString();
    var tagsJson = jsonDecode(recievedJson);

    List<String> tags = tagsJson != null ? List.from(tagsJson) : null;
    return tags;
  }

  _getBasketItem(int index) {
    List tags = _decodeBasket();
    for (int i = 0; i < catalog.length; i++) {
      if (tags.contains(catalog[i]["_id"])) {
        if (tags[index] == catalog[i]["_id"]) {
          return catalog[i]["productName"].toString();
        }
      }
    }
  }

  _getBasketPrice(int index) {
    List tags = _decodeBasket();
    for (int i = 0; i < catalog.length; i++) {
      if (tags.contains(catalog[i]["_id"])) {
        if (tags[index] == catalog[i]["_id"]) {
          String price = catalog[i]["productPrice"].toString();
          return double.parse(price);
        }
      }
    }
  }

  _removeBasketItem(int index) {
    return list.removeAt(index);
  }

  _removeWholeBasket() {
    return list.clear();
  }

  _addPrices() {
    double counter = 0;
    for (int i = 0; i < list.length; i++) {
      double temp = _getBasketPrice(i);
      counter += temp;
    }
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    _addPrices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        Navigator.pop(context, _removeBasketItem(index));
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
          ));
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_forever),
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context, _removeWholeBasket());
              },
              iconSize: 40,
            ),
            Text(
              "Total: £" + _addPrices().toString(),
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
