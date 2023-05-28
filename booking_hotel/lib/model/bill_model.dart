import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class BillModel {
  String? billid;
  String? roomid;
  int floor;
  int capacity;
  int cost;
  String? userid;
  String email;
  String name;
  String phone;
  Timestamp daystart;
  Timestamp dayend;
  int totalcost;

  BillModel(
      {this.billid,
      this.roomid,
      required this.floor,
      required this.capacity,
      required this.cost,
      this.userid,
      required this.email,
      required this.name,
      required this.phone,
      required this.daystart,
      required this.dayend,
      required this.totalcost});

  toJson() {
    return {
      'roomid': roomid,
      'floor': floor,
      'capacity': capacity,
      'cost': cost,
      'userid': userid,
      'email': email,
      'name': name,
      'phone': phone,
      'daystart': daystart,
      'dayend': dayend,
      'totalcost': totalcost
    };
  }

  factory BillModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BillModel(
        billid: document.id,
        roomid: data['roomid'],
        floor: data['floor'],
        capacity: data['capacity'],
        cost: data['cost'],
        userid: data['userid'],
        email: data['email'],
        name: data['name'],
        phone: data['phone'],
        daystart: data['daystart'],
        dayend: data['dayend'],
        totalcost: data['totalcost']);
  }
}
