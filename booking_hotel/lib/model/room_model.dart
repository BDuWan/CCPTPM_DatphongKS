import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String? id;
  final int floor;
  final int numofper;
  final int cost;

  const RoomModel(
      {this.id,
      required this.floor,
      required this.numofper,
      required this.cost});

  toJson() {
    return {'id': id, 'floor': floor, 'numofper': numofper, 'cost': cost};
  }

  factory RoomModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RoomModel(
      id: document.id,
      floor: data['floor'],
      numofper: data['numofper'],
      cost: data['cost'],
    );
  }
}
