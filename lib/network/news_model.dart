class NewsModel {
  String id;
  String name;
  String description;
  String imageUrl;
  NewsModel({this.id, this.name, this.description, this.imageUrl});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json[id];
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['ímage_url'] = this.imageUrl;
    return data;
  }
}
