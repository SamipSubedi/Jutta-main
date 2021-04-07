import 'dart:convert';

class ShoesModel {
  String id;
  String name;
  String description;
  String imageUrl;
  String size;
  String price;
  ShoesModel(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.size,
      this.price});

  ShoesModel.fromJson(Map<String, dynamic> json) {
    id = json[id];
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    size = (json['size']).toString();
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['ímage_url'] = this.imageUrl;
    data['size'] = this.size;
    data['price'] = this.price;
    return data;
  }
}
