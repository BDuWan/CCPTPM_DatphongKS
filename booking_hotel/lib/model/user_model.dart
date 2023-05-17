import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? id;
  String name;
  String phone;

  UserModel({
    this.id,
    required this.name,
    required this.phone,
  });

  toJson() {
    return {'id': id, 'name': name, 'phone': phone};
  }

  factory UserModel.fromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
    return UserModel(
      id: snapshot.key ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
}


