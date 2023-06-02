import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MyProvider extends ChangeNotifier {
  late String curUserId;
  late String curEmail;
  late String roomId;
  late int floor;
  late int capacity;
  late int lowcost;
  late int highcost;
  late String? choosedRoomId;
  late String? choosedBillId;
  late DateTime startDate;
  late DateTime endDate;

  void setCurUserId(String id) {
    curUserId = id;
    notifyListeners();
  }

  void setCurEmail(String email) {
    curEmail = email;
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

  void setCapacity(int _capacity) {
    capacity = _capacity;
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

  void setChoosedRoomId(String? _choosedRoomId) {
    choosedRoomId = _choosedRoomId;
    notifyListeners();
  }

  void setChoosedBillId(String? _choosedBillId) {
    choosedBillId = _choosedBillId;
    notifyListeners();
  }

  void setstartDate(String _startDate) {
    startDate = DateFormat('dd/MM/yyyy').parse(_startDate);
    notifyListeners();
  }

  void setendDate(String _endDate) {
    endDate = DateFormat('dd/MM/yyyy').parse(_endDate);
    notifyListeners();
  }
}
