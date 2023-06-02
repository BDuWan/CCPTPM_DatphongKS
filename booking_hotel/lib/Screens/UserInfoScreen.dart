import 'package:booking_hotel/Helper.dart';
import 'package:booking_hotel/Screens/UpdateUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../providers/provider.dart';
import '../repository/user_repository.dart';
import 'bottom_navigation.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
      ),
      body: Column(
        children: [
          const UserInfo(),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Helper.nextPage(context, const UpdateUserScreen());
            },
            child: const Text(
                style: TextStyle(fontSize: 20), 'Cập nhật thông tin cá nhân'),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 2,
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    const textStyle1 = TextStyle(
      fontSize: 22,
      height: 2,
    );
    MyProvider provider = context.read<MyProvider>();
    Get.put(UserRepository());
    return FutureBuilder<UserModel>(
      future: UserRepository().getUserById(provider.curUserId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          provider.setCurEmail(user.email);
          return Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Họ tên: ${user.name}',
                  style: textStyle1,
                ),
                Text(
                  'Email: ${user.email}',
                  style: textStyle1,
                ),
                Text(
                  'Số điện thoại: ${user.phone}',
                  style: textStyle1,
                ),
                Text(
                  'Địa chỉ: ${user.address}',
                  style: textStyle1,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Đã xảy ra lỗi khi tải thông tin người dùng');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
