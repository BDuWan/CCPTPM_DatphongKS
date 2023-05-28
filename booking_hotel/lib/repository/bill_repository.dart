import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/bill_model.dart';

class BillRepository extends GetxController {
  static BillRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;

  createBill(bill, Function onSuccess) async {
    await db
        .collection('bills')
        .doc()
        .set(bill.toJson())
        .whenComplete({onSuccess()} as FutureOr<void> Function())
        .catchError((err) {
      "Đặt phòng thất bại, vui lòng thử lại";
    });
  }

  Future<BillModel> getBillById(String? id) async {
    final snapshot = await db
        .collection('bills')
        .where(FieldPath.documentId, isEqualTo: id)
        .get();
    final billdata = snapshot.docs.map((e) => BillModel.fromSnapShot(e)).single;
    return billdata;
  }

  Stream<List<BillModel>> getListBillByRoomId(String? roomid) {
    return db
        .collection('bills')
        .where('roomid', isEqualTo: roomid)
        .orderBy('daystart')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => BillModel.fromSnapShot(doc)).toList());
  }

  Stream<List<BillModel>> getListBillByUserId(String? userid) {
    return db
        .collection('bills')
        .where('userid', isEqualTo: userid)
        .orderBy('daystart')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => BillModel.fromSnapShot(doc)).toList());
  }
}
