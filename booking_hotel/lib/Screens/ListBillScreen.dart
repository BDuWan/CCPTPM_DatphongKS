import 'package:booking_hotel/Screens/BillInfoScreen.dart';
import 'package:booking_hotel/Screens/BookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Helper.dart';
import '../model/bill_model.dart';
import '../providers/provider.dart';
import '../repository/bill_repository.dart';
import 'bottom_navigation.dart';

class ListBillScreen extends StatefulWidget {
  const ListBillScreen({super.key});

  @override
  State<ListBillScreen> createState() => _ListBillScreenState();
}

class _ListBillScreenState extends State<ListBillScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách hóa đơn của bạn'),
      ),
      body: const ListBill(),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1,),
    );
  }
}

class ListBill extends StatefulWidget {
  const ListBill({Key? key}) : super(key: key);

  @override
  State<ListBill> createState() => _ListBillState();
}

class _ListBillState extends State<ListBill> {
  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    Get.put(BillRepository());
    return StreamBuilder<List<BillModel>>(
      stream: BillRepository().getListBillByUserId(provider.curUserId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bills = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemExtent: 80,
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
                title: Text('Phòng ${bill.roomid}',
                    style: const TextStyle(fontSize: 20)),
                subtitle: Text(
                  '$formattedStartDate - $formattedEndDate',
                  style: const TextStyle(fontSize: 20),
                ),
                  onTap: () {
                    provider.setChoosedBillId(bill.billid);
                    Helper.nextPage(context, const BillInfoScreen());
                  }
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Đã xảy ra lỗi khi tải danh sách hóa đơn');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
