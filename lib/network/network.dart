import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shoesfyp2/network/cart_model.dart';
import 'package:shoesfyp2/network/shoes_model.dart';

import '../constants.dart';
import 'news_model.dart';

getShoesList({String cityName}) async {
  var finalUrl = Constants.apiURL +
      "shoe"; // change to metric or imperial //metric = celcius

  final response = await http.get(Uri.encodeFull(finalUrl));
  print("URL: ${Uri.encodeFull(finalUrl)}");

  if (response.statusCode == 200) {
    var extractedData = json.decode(response.body);
    print(response.body);
    List<ShoesModel> loadedData = [];

    extractedData.asMap().forEach((_, data) {
      loadedData.add(ShoesModel.fromJson(data));
    });

    return loadedData;
  } else {
    throw Exception("Error getting Data from Database");
  }
}

addtoCart(String itemID, userID) async {
  var finalUrl = "${Constants.apiURL}add_to_cart";
  print("ITEM ID: $itemID");
  print("userID $userID");
  print("URL: $finalUrl");
  // {"item_id": itemID, "user_id": userID.toString()}
  // var uri = Uri.encodeFull('http://{{api_url}}/account/authenticate');
  var response = await http.post(finalUrl,
      body: jsonEncode({"item_id": itemID, "user_id": userID.toString()}),
      headers: {HttpHeaders.contentTypeHeader: " application/json"});

//Here you get the 308 error.

  final getResponse = await http.post(response.headers["location"],
      body: jsonEncode({"item_id": itemID, "user_id": userID.toString()}),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
  print(getResponse.body);
}

getCartList(String userID) async {
  var finalUrl = "${Constants.apiURL}view_cart/$userID";

  final response = await http.get(finalUrl);
  print("URL: ${Uri.encodeFull(finalUrl)}");
  if (response.statusCode == 200) {
    var extractedData = json.decode(response.body);
    print(response.body);
    List<CartModel> loadedData = [];

    extractedData.asMap().forEach((_, data) {
      loadedData.add(CartModel.fromJson(data));
    });
    print(loadedData);
    return loadedData;
  } else {
    throw Exception("Error getting Data from Database");
  }
}

getNewsList({String cityName}) async {
  var finalUrl = Constants.apiURL +
      "news"; // change to metric or imperial //metric = celcius

  final response = await http.get(Uri.encodeFull(finalUrl));
  print("URL: ${Uri.encodeFull(finalUrl)}");

  if (response.statusCode == 200) {
    var extractedData = json.decode(response.body);
    print(response.body);
    List<NewsModel> loadedData = [];

    extractedData.asMap().forEach((_, data) {
      loadedData.add(NewsModel.fromJson(data));
    });

    return loadedData;
  } else {
    throw Exception("Error getting Data from Database");
  }
}
