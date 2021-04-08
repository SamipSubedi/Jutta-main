import 'dart:convert';

import 'package:http/http.dart' as http;
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
  var finalUrl = "${Constants.apiURL}add_to_card";

  final response =
      await http.post(finalUrl, body: {"item_id": itemID, "user_id": userID});
  print(response.body);
  print("URL: ${Uri.encodeFull(finalUrl)}");
}
