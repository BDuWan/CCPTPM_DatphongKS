import 'package:booking_hotel/model/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RoomRepository extends GetxController {
  static RoomRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<RoomModel>> getRoomById(String id) async {
    final snapshot = await _db
        .collection('rooms')
        .where(FieldPath.documentId, isEqualTo: id)
        .get();
    final roomdata =
        snapshot.docs.map((e) => RoomModel.fromSnapShot(e)).toList();
    return roomdata;
  }

  Future<List<RoomModel>> allRoom() async {
    final snapshot = await _db.collection("rooms").get();
    final roomdata =
        snapshot.docs.map((e) => RoomModel.fromSnapShot(e)).toList();
    return roomdata;
  }

  Future<List<RoomModel>> getRoomWithQuery(int numofper, int floor, int lowcost, int highcost) async {
    final snapshot = await _db
        .collection("rooms")
        .where('numofper', isEqualTo: numofper)
        .where('floor', isEqualTo: floor)
        .where('cost', isGreaterThan: lowcost)
        .where('cost', isLessThan: highcost)
        .get();
    final roomdata =
        snapshot.docs.map((e) => RoomModel.fromSnapShot(e)).toList();
    return roomdata;
  }
}
