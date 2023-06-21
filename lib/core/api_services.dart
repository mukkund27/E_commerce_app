import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_com/data/Model/api_responce_model.dart';
import 'package:e_com/data/Model/cart_item_model.dart';
import 'package:e_com/data/Model/category_model.dart';
import 'package:e_com/data/Model/product_model.dart';
import 'package:e_com/data/Model/user_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseURl = "https://e-commerce-jrn9.onrender.com/api";
const Map<String, dynamic> defaultHeaders = {
  'content-Type': 'application/json',
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = baseURl;
    _dio.options.headers = defaultHeaders;
    _dio.interceptors.add(
      PrettyDioLogger(requestBody: true, responseBody: true, requestHeader: true, responseHeader: true),
    );
  }

  Dio get sendRequest => _dio;
}

class ApiService {
  static final api = Api();

  static Future<UserModel> createAccount({required String email, required String password}) async {
    try {
      var response = await api.sendRequest.post("/user/createAccount",
          data: jsonEncode(
            {
              "email": email,
              "password": password,
            },
          ));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  static Future<UserModel> signIn({required String email, required String password}) async {
    try {
      var response = await api.sendRequest.post("/user/signIn",
          data: jsonEncode(
            {
              "email": email,
              "password": password,
            },
          ));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  static Future<List<CategoryModel>> fetchAllCategory() async {
    try {
      var response = await api.sendRequest.get(
        "/category/allCategory",
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((e) => CategoryModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  static Future<List<ProductModel>> fetchAllProduct() async {
    try {
      var response = await api.sendRequest.get(
        "/product/allProduct",
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  static Future<List<ProductModel>> fetchProductByCategory(String categoryId) async {
    try {
      var response = await api.sendRequest.get(
        "/product/productByCategory/$categoryId",
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  static Future<List<CartModel>> fetchCartForUSer(String userId) async {
    try {
      var response = await api.sendRequest.get(
        "/cart/getUserCart/$userId",
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((e) => CartModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  static Future<List<CartModel>> addToCart(CartModel cartModel, String userId) async {
    try {

      Map<String, dynamic> dataBody = cartModel.toJson();
      dataBody["user"] = userId;
      var response = await api.sendRequest.post("/cart/addToCart", data: jsonEncode(dataBody));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>).map((e) => CartModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  static Future<List<CartModel>> removeFromCart(String productId, String userId) async {
    try {
      Map<String, dynamic> dataBody = {"product": productId, "user": userId};
      var response = await api.sendRequest.delete("/cart/removeFromCart", data: jsonEncode(dataBody));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((e) => CartModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}
