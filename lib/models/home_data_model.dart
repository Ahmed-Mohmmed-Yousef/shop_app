import 'dart:convert';

import 'package:flutter/foundation.dart';

class HomeDataResponseModel {
  bool status;
  String? message;
  HomeData? data;

  HomeDataResponseModel({
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

  factory HomeDataResponseModel.fromMap(Map<String, dynamic> map) {
    return HomeDataResponseModel(
      status: map['status'] ?? false,
      message: map['message'],
      data: map['data'] != null ? HomeData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeDataResponseModel.fromJson(String source) => HomeDataResponseModel.fromMap(json.decode(source));
}

class HomeData {
  List<Banner> banners;
  List<Product> products;
  String ad;

  HomeData({
    required this.banners,
    required this.products,
    required this.ad,
  });

  Map<String, dynamic> toMap() {
    return {
      'banners': banners.map((x) => x.toMap()).toList(),
      'products': products.map((x) => x.toMap()).toList(),
      'ad': ad,
    };
  }

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      banners: List<Banner>.from(map['banners']?.map((x) => Banner.fromMap(x))),
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
      ad: map['ad'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeData.fromJson(String source) => HomeData.fromMap(json.decode(source));
}

class Banner {
  int id;
  String image;
  Banner({
    required this.id,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Banner.fromJson(String source) => Banner.fromMap(json.decode(source));
}

class Product {
  int id;
  double price;
  double oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
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
      'images': images,
      'inFavorites': inFavorites,
      'inCart': inCart,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      oldPrice: map['oldPrice']?.toDouble() ?? 0.0,
      discount: map['discount']?.toInt() ?? 0,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      inFavorites: map['inFavorites'] ?? false,
      inCart: map['inCart'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
