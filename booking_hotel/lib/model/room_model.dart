import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  String? roomid;
  int floor;
  int capacity;
  int cost;

  RoomModel(
      {this.roomid,
      required this.floor,
      required this.capacity,
      required this.cost});

  toJson() {
    return {'id': roomid, 'floor': floor, 'capacity': capacity, 'cost': cost};
  }

  factory RoomModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RoomModel(
      roomid: document.id,
      floor: data['floor'],
      capacity: data['capacity'],
      cost: data['cost'],
    );
  }
}
