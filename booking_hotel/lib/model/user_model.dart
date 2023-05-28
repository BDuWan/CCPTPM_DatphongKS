import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userid;
  String email;
  String name;
  String phone;

  UserModel({
    this.userid,
    required this.email,
    required this.name,
    required this.phone,
  });

  toJson() {
    return {'email': email, 'name': name, 'phone': phone};
  }


  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      userid: document.id,
      email: data['email'],
      name: data['name'],
      phone: data['phone'],
    );
  }
}


