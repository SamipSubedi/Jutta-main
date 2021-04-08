class CartModel {
  String created_id;
  String item_id;
  String inventory;
  String updated_id;
  String user_id;
  String id;
  String name;
  String description;
  String imageUrl;
  String size;
  String price;
  String shoe_size;
  CartModel(
      {this.created_id,
      this.item_id,
      this.inventory,
      this.updated_id,
      this.user_id,
      this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.size,
      this.price,
      this.shoe_size});

  CartModel.fromJson(Map<String, dynamic> json) {
    created_id = json['created_id'];
    item_id = json['item_id'];
    inventory = json['inventory'];
    updated_id = json['updated_id'];
    user_id = json['user_id'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    size = (json['size']).toString();
    price = json['price'];
    shoe_size = json['shoe_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_id'] = this.created_id;
    data['item_id'] = this.item_id;
    data['inventory'] = this.inventory;
    data['updated_id'] = this.updated_id;
    data['user_id'] = this.user_id;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['ímage_url'] = this.imageUrl;
    data['size'] = this.size;
    data['price'] = this.price;
    data['shoe_size'] = this.shoe_size;
    return data;
  }
}
