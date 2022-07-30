import 'dart:convert';

class CategoriesResponseModel {
  bool status;
  String? message;
  CategoryPageModel data;
  CategoriesResponseModel({
    required this.status,
    this.message,
    required this.data,
  });


  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory CategoriesResponseModel.fromMap(Map<String, dynamic> map) {
    return CategoriesResponseModel(
      status: map['status'] ?? false,
      message: map['message'],
      data: CategoryPageModel.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesResponseModel.fromJson(String source) => CategoriesResponseModel.fromMap(json.decode(source));
}

class CategoryPageModel {
  int currentPage;
  List<CategoryModel> data;
  CategoryPageModel({
    required this.currentPage,
    required this.data,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'current_page': currentPage,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryPageModel.fromMap(Map<String, dynamic> map) {
    return CategoryPageModel(
      currentPage: map['current_age']?.toInt() ?? 0,
      data: List<CategoryModel>.from(map['data']?.map((x) => CategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryPageModel.fromJson(String source) => CategoryPageModel.fromMap(json.decode(source));
}

class CategoryModel {
  int id;
  String name;
  String image;
  
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source));
}
