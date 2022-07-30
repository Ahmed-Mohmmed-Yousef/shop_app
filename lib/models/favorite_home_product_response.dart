import 'dart:convert';

import 'package:shop_app/models/home_data_model.dart';

class ChangeFavoriateResponseModel {
  bool status;
  String message;
  ChangeFavoriateResponseModel({
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory ChangeFavoriateResponseModel.fromMap(Map<String, dynamic> map) {
    return ChangeFavoriateResponseModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeFavoriateResponseModel.fromJson(String source) =>
      ChangeFavoriateResponseModel.fromMap(json.decode(source));
}


class GetFavoriteResponseModel {
  bool status;
  String? message;
  FavoriteProductData? data;

  GetFavoriteResponseModel({
    required this.status,
    this.message,
    this.data,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory GetFavoriteResponseModel.fromMap(Map<String, dynamic> map) {
    return GetFavoriteResponseModel(
      status: map['status'] ?? false,
      message: map['message'],
      data: map['data'] != null ? FavoriteProductData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetFavoriteResponseModel.fromJson(String source) => GetFavoriteResponseModel.fromMap(json.decode(source));
}

class FavoriteProductData {
  int currentPage;
  List<FavoriteProduct>? favorites;

  FavoriteProductData({
    required this.currentPage,
    this.favorites,
  });



  Map<String, dynamic> toMap() {
    return {
      'currentPage': currentPage,
      'data': favorites?.map((x) => x.toMap()).toList(),
    };
  }

  factory FavoriteProductData.fromMap(Map<String, dynamic> map) {
    return FavoriteProductData(
      currentPage: map['currentPage']?.toInt() ?? 0,
      favorites: map['data'] != null ? List<FavoriteProduct>.from(map['data']?.map((x) => FavoriteProduct.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteProductData.fromJson(String source) => FavoriteProductData.fromMap(json.decode(source));
}

class FavoriteProduct {
  int id;
  FProduct? product;

  FavoriteProduct({
    required this.id,
    this.product,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product?.toMap(),
    };
  }

  factory FavoriteProduct.fromMap(Map<String, dynamic> map) {
    return FavoriteProduct(
      id: map['id']?.toInt() ?? 0,
      product: map['product'] != null ? FProduct.fromMap(map['product']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteProduct.fromJson(String source) => FavoriteProduct.fromMap(json.decode(source));
}

class FProduct {
  double id;
  double price;
  double oldPrice;
  double discount;
  String image;
  String name;
  String description;

  FProduct({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'oldPrice': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
    };
  }

  factory FProduct.fromMap(Map<String, dynamic> map) {
    return FProduct(
      id: map['id']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      oldPrice: map['oldPrice']?.toDouble() ?? 0.0,
      discount: map['discount']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FProduct.fromJson(String source) => FProduct.fromMap(json.decode(source));
}
