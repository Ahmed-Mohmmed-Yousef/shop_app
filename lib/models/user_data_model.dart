import 'dart:convert';

class GetProfileResponseModel {
  bool status;
  String? message;
  UserDataModel? userData;
  GetProfileResponseModel({
    required this.status,
    this.message,
    this.userData,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': userData?.toMap(),
    };
  }

  factory GetProfileResponseModel.fromMap(Map<String, dynamic> map) {
    return GetProfileResponseModel(
      status: map['status'] ?? false,
      message: map['message'],
      userData: map['data'] != null ? UserDataModel.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetProfileResponseModel.fromJson(String source) => GetProfileResponseModel.fromMap(json.decode(source));
}

class UserDataModel {
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;
  UserDataModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'points': points,
      'credit': credit,
      'token': token,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      points: map['points']?.toInt() ?? 0,
      credit: map['credit']?.toInt() ?? 0,
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) => UserDataModel.fromMap(json.decode(source));
}
