import 'package:booking_hotel/model/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RoomRepository extends GetxController{
  static RoomRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;
  /*final db;

  RoomRepository({required this.db});*/

  Future<List<RoomModel>> getListRoomById(String id) async {
    final snapshot = await db
        .collection('rooms')
        .where(FieldPath.documentId, isEqualTo: id)
        .get();
    final roomdata =
        snapshot.docs.map((e) => RoomModel.fromSnapShot(e)).toList();
    return roomdata;
  }

  Future<RoomModel> getRoomById(String? id) async {
    final snapshot = await db
        .collection('rooms')
        .doc(id)
        .get();
    final roomdata = RoomModel.fromSnapShot(snapshot);
    return roomdata;
  }

  Future<List<RoomModel>> allRoom() async {
    final snapshot = await db.collection("rooms").get();
    final roomdata =
        snapshot.docs.map((e) => RoomModel.fromSnapShot(e)).toList();
    return roomdata;
  }

  Future<List<RoomModel>> getRoomWithQuery(
      int floor, int capacity, int lowcost, int highcost) async {
    final snapshot = await db
        .collection("rooms")
        .where('capacity', isEqualTo: capacity)
        .where('floor', isEqualTo: floor)
        .where('cost', isGreaterThanOrEqualTo: lowcost)
        .where('cost', isLessThanOrEqualTo: highcost)
        .orderBy('cost')
        .get();
    final roomdata =
        snapshot.docs.map((e) => RoomModel.fromSnapShot(e)).toList();
    return roomdata;
  }
}
