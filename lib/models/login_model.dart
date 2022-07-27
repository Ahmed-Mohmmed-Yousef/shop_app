import 'dart:convert';

class LoginModel {
  bool status;
  String message;
  UserData? data;
  LoginModel({
    required this.status,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
      data: map['data'] != null ? UserData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source));
}

class UserData {
  int id;

  String name;

  String email;

  String phone;

  String image;

  String token;
  
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'token': token
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source));
}
