import 'dart:convert';

class ShoesModel {
  String id;
  String name;
  String description;
  String imageUrl;
  String size;
  String price;
  String items;
  String rating;
  ShoesModel(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.size,
      this.price,
      this.items,
      this.rating});

  ShoesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    size = (json['size']).toString();
    price = json['price'];
    items = json['item_bought_together'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['ímage_url'] = this.imageUrl;
    data['size'] = this.size;
    data['price'] = this.price;
    data['item_bought_together'] = this.items;
    data['rating'] = this.rating;
    return data;
  }
}
