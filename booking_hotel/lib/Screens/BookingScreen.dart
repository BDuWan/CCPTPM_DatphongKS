import 'package:booking_hotel/dialog/MsgDialog.dart';
import 'package:booking_hotel/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../model/bill_model.dart';
import '../model/room_model.dart';
import '../model/user_model.dart';
import '../providers/provider.dart';
import '../repository/bill_repository.dart';
import '../repository/room_repository.dart';
import 'package:intl/intl.dart';

import 'bottom_navigation.dart';

late Stream<List<BillModel>> billStream;
List<BillModel> bills = [];

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin chi tiết phòng'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            RoomInfor(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Những ngày đã được đặt trước',
              style: TextStyle(fontSize: 25),
            ),
            ListDay(),
            SizedBox(
              height: 20,
            ),
            Booking(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 0,
      ),
    );
  }
}

class RoomInfor extends StatefulWidget {
  const RoomInfor({Key? key}) : super(key: key);

  @override
  State<RoomInfor> createState() => _RoomInforState();
}

class _RoomInforState extends State<RoomInfor> {
  @override
  Widget build(BuildContext context) {
    const textStyle1 = TextStyle(
      fontSize: 20,
      height: 2,
    );
    MyProvider provider = context.read<MyProvider>();
    Get.put(RoomRepository());
    return FutureBuilder<RoomModel>(
      future: RoomRepository.instance.getRoomById(provider.choosedRoomId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final room = snapshot.data!;
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số phòng: ${room.roomid}',
                  style: textStyle1,
                ),
                Text(
                  'Tầng: ${room.floor}',
                  style: textStyle1,
                ),
                Text(
                  'Số người: ${room.capacity}',
                  style: textStyle1,
                ),
                Text(
                  'Giá thuê 1 ngày: ${room.cost}',
                  style: textStyle1,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Đã xảy ra lỗi khi tải thông tin phòng');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ListDay extends StatefulWidget {
  const ListDay({Key? key}) : super(key: key);

  @override
  State<ListDay> createState() => _ListDayState();
}

class _ListDayState extends State<ListDay> {
  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    Get.put(BillRepository());
    return StreamBuilder<List<BillModel>>(
      stream:
          BillRepository.instance.getListBillByRoomId(provider.choosedRoomId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bills = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemExtent: 40,
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final bill = bills[index];
              DateTime startDate = bill.daystart.toDate();
              DateTime endDate = bill.dayend.toDate();
              String formattedStartDate =
                  DateFormat('dd/MM/yyyy').format(startDate);
              String formattedEndDate =
                  DateFormat('dd/MM/yyyy').format(endDate);
              return ListTile(
                subtitle: Text(
                  '$formattedStartDate - $formattedEndDate',
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        startDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        endDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Chọn thời gian đặt phòng',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: startDateController,
            onTap: _selectStartDate,
            decoration: const InputDecoration(
              labelText: 'Ngày bắt đầu',
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: endDateController,
            onTap: _selectEndDate,
            decoration: const InputDecoration(
              labelText: 'Ngày kết thúc',
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              if (startDateController.text.isEmpty ||
                  endDateController.text.isEmpty) {
                MsgDialog.showMsgDialog(
                    context, 'Thông báo', 'Bạn chưa nhập thời gian đặt phòng');
              } else {
                provider.setstartDate(startDateController.text);
                provider.setendDate(endDateController.text);

                switch (checkDay(bills, provider.startDate, provider.endDate)) {
                  case 0:
                    createBill(context);
                    break;
                  case 1:
                    MsgDialog.showMsgDialog(context, 'Thông báo',
                        'Ngày bắt đầu phải trước hoặc bằng ngày kết thúc');
                    break;
                  case 2:
                    MsgDialog.showMsgDialog(context, 'Thông báo',
                        'Vui lòng nhập thời điểm sau ngày hiện tại');
                    break;
                  case 3:
                    MsgDialog.showMsgDialog(context, 'Thông báo',
                        'Ngày bạn nhập đã có người đặt trước');
                    break;
                }
              }
            },
            child: const Text(style: TextStyle(fontSize: 20), 'Đặt phòng'),
          ),
        ],
      ),
    );
  }
}

int checkDay(List<BillModel> bills, DateTime startDay, DateTime endDay) {
  DateTime now = DateTime.now();
  if (startDay.isAfter(endDay)) {
    return 1;
  } else if (startDay.isBefore(now) || startDay.isAtSameMomentAs(now)) {
    return 2;
  }
  for (var bill in bills) {
    DateTime day1 = bill.daystart.toDate();
    DateTime day2 = bill.dayend.toDate();
    if ((startDay.isBefore(day2) || startDay.isAtSameMomentAs(day2)) &&
        (endDay.isAfter(day1) || endDay.isAtSameMomentAs(day1))) {
      return 3;
    }
  }
  return 0;
}

Future<void> createBill(BuildContext context) async {
  MyProvider provider = context.read<MyProvider>();
  UserModel user = await UserRepository().getUserById(provider.curUserId);
  RoomModel room = await RoomRepository().getRoomById(provider.choosedRoomId);
  int totalcost =
      (provider.endDate.difference(provider.startDate).inDays + 1) * room.cost;
  BillModel bill = BillModel(
      roomid: room.roomid,
      floor: room.floor,
      capacity: room.capacity,
      cost: room.cost,
      userid: user.userid,
      email: user.email,
      name: user.name,
      phone: user.phone,
      daystart: Timestamp.fromDate(provider.startDate),
      dayend: Timestamp.fromDate(provider.endDate),
      totalcost: totalcost);
  BillRepository().createBill(bill, () {
    MsgDialog.showMsgDialog(
        context, 'Thông báo', 'Chúc mừng bạn đã đặt phòng thành công');
  });
}
