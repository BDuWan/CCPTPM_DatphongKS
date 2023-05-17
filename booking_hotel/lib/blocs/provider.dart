import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MyProvider extends ChangeNotifier {
  late String userId;
  late String roomId;
  late int floor;
  late int numofper;
  late int lowcost;
  late int highcost;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }

  void setRoomId(String id) {
    roomId = id;
    notifyListeners();
  }

  void setFloor(int _floor) {
    floor = _floor;
    notifyListeners();
  }

  void setNumofper(int _numofper) {
    numofper = _numofper;
    notifyListeners();
  }

  void setLowcost(int _lowcost) {
    lowcost = _lowcost;
    notifyListeners();
  }

  void setHighcost(int _highcost) {
    highcost = _highcost;
    notifyListeners();
  }
}
