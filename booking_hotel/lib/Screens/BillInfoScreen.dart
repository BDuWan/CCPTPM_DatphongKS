import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/bill_model.dart';
import '../providers/provider.dart';
import '../repository/bill_repository.dart';
import 'bottom_navigation.dart';

class BillInfoScreen extends StatefulWidget {
  const BillInfoScreen({Key? key}) : super(key: key);

  @override
  State<BillInfoScreen> createState() => _BillInfoScreenState();
}

class _BillInfoScreenState extends State<BillInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin hóa đơn'),),
      body: const BillInfo(),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1,),
    );
  }
}

class BillInfo extends StatefulWidget {
  const BillInfo({Key? key}) : super(key: key);

  @override
  State<BillInfo> createState() => _BillInfoState();
}

class _BillInfoState extends State<BillInfo> {
  @override
  Widget build(BuildContext context) {
    const textStyle1 = TextStyle(
      fontSize: 20,
      height: 2,
    );
    MyProvider provider = context.read<MyProvider>();
    Get.put(BillRepository());
    return FutureBuilder<BillModel>(
      future: BillRepository.instance.getBillById(provider.choosedBillId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final bill = snapshot.data!;
          DateTime startDate = bill.daystart.toDate();
          DateTime endDate = bill.dayend.toDate();
          String formattedStartDate =
          DateFormat('dd/MM/yyyy').format(startDate);
          String formattedEndDate =
          DateFormat('dd/MM/yyyy').format(endDate);
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số phòng: ${bill.roomid}',
                  style: textStyle1,
                ),
                Text(
                  'Tầng: ${bill.floor}',
                  style: textStyle1,
                ),
                Text(
                  'Số người: ${bill.capacity}',
                  style: textStyle1,
                ),
                Text(
                  'Giá thuê 1 ngày: ${bill.cost}',
                  style: textStyle1,
                ),
                Text(
                  'Tên người thuê: ${bill.name}',
                  style: textStyle1,
                ),
                Text(
                  'Số điện thoại: ${bill.phone}',
                  style: textStyle1,
                ),
                Text(
                  'Email: ${bill.email}',
                  style: textStyle1,
                ),
                const Text(
                  'Thời gian thuê:',
                  style: textStyle1,
                ),
                Text(
                  'Từ: $formattedStartDate',
                  style: textStyle1,
                ),
                Text(
                  'Đến: $formattedEndDate',
                  style: textStyle1,
                ),
                Text(
                  'Tổng tiền: ${bill.totalcost}',
                  style: textStyle1,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Đã xảy ra lỗi khi tải thông tin hóa đơn');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
