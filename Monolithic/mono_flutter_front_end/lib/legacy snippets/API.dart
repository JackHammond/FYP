import 'dart:async';
import 'package:http/http.dart' as http;

//const baseUrl = "https://jsonplaceholder.typicode.com";
const newUrl =  "https://api.myjson.com/bins/";

class API {
    static Future getProducts() {
    var url = newUrl + "/xutvq";
    return http.get(url);
  }
}