class CategoryModel {
  String? sId;
  String? title;
  String? description;
  String? updatedOn;
  String? createdOn;

  CategoryModel(
      {this.sId, this.title, this.description, this.updatedOn, this.createdOn});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    updatedOn = json['updated_on'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['updated_on'] = this.updatedOn;
    data['created_on'] = this.createdOn;
    return data;
  }
}
