// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'Catalog.dart';

// //const baseUrl = "https://jsonplaceholder.typicode.com";
// const baseUrl = "https://api.myjson.com/bins/";

// class API {
//   static Future<List<Catalog>> fetchCatalog(http.Client client) async {
//     final response = await client.get(getCatalog());

//     // Use the compute function to run parseProducts in a separate isolate.
//     return compute(parseCatalog, response.body);
//   }

//   // A function that converts a response body into a List<Product>.
//   static List<Catalog> parseCatalog(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

//     return parsed.map<Catalog>((json) => Catalog.fromJson(json)).toList();
//   }

//   //Return string to prevent double future calls
//   static String getCatalog() {
//     var url = baseUrl + "/xutvq";
//     return url;
//   }
// }
