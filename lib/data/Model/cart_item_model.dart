import 'package:e_com/data/Model/product_model.dart';

class CartModel {
  ProductModel? product;
  int? quantity;
  String? sId;

  CartModel({this.quantity, this.sId,this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    product=ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] =product!.sId;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}
