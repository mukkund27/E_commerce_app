class ProductModel {
  String? sId;
  String? category;
  String? title;
  String? description;
  int? price;
  List<String>? images;
  String? updatedOn;
  String? createdOn;
  int? iV;

  ProductModel(
      {this.sId,
        this.category,
        this.title,
        this.description,
        this.price,
        this.images,
        this.updatedOn,
        this.createdOn,
        this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    updatedOn = json['updated_on'];
    createdOn = json['created_on'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['updated_on'] = this.updatedOn;
    data['created_on'] = this.createdOn;
    data['__v'] = this.iV;
    return data;
  }
}
