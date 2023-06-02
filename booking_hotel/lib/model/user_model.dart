import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userid;
  String email;
  String name;
  String phone;
  String address;

  UserModel({
    this.userid,
    required this.email,
    required this.name,
    required this.phone,
    required this.address
  });

  toJson() {
    return {'email': email, 'name': name, 'phone': phone, 'address': address};
  }


  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      userid: document.id,
      email: data['email'],
      name: data['name'],
      phone: data['phone'],
      address: data['address']
    );
  }
}


