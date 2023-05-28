import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;
  /*final  db;

  UserRepository({required this.db});*/

  createUser(String userid, user, Function onSuccess) async {
    await db
        .collection('userinfo')
        .doc(userid)
        .set(user.toJson())
        .whenComplete({
    onSuccess()
    } as FutureOr<void> Function()).catchError((err) {
    "Đăng kí thất bại, vui lòng thử lại";
    });
  }

  Future<UserModel> getUserById(String id) async {
    final snapshot = await db
        .collection('userinfo')
        .doc(id)
        .get();
    final userdata = UserModel.fromSnapShot(snapshot);
    return userdata;
  }
}
