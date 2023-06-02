import 'package:booking_hotel/Helper.dart';
import 'package:booking_hotel/Screens/UserInfoScreen.dart';
import 'package:booking_hotel/Screens/bottom_navigation.dart';
import 'package:booking_hotel/dialog/MsgDialog.dart';
import 'package:booking_hotel/model/user_model.dart';
import 'package:booking_hotel/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dialog/LoadingDialog.dart';
import '../providers/provider.dart';

class UpdateUserScreen extends StatelessWidget {
  const UpdateUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sửa thông tin cá nhân')),
      body: const UpdateUserInfo(),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 2,
      ),
    );
  }
}

class UpdateUserInfo extends StatefulWidget {
  const UpdateUserInfo({Key? key}) : super(key: key);

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  String fullname = '';
  String phone = '';
  String address = '';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MyProvider provider = context.read<MyProvider>();
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  fullname = value;
                });
              },
              validator: (value) {
                fullname = value!;
                if (fullname.isEmpty) {
                  return 'Bạn chưa nhập tên';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Full name',
                  hintText: 'Nhập họ tên của bạn',
                  prefixIcon: Image.asset(
                    'assets/images/user_name.png',
                    width: 30,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  phone = value;
                });
              },
              validator: (value) {
                phone = value!;
                if (phone.isEmpty) {
                  return 'Bạn chưa nhập số điện thoại';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Nhập số điện thoại',
                  prefixIcon: Image.asset(
                    'assets/images/phone_icon.png',
                    width: 30,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              validator: (value) {
                address = value!;
                if (address.isEmpty) {
                  return 'Bạn chưa nhập địa chỉ';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Nhập địa chỉ',
                  prefixIcon: Image.asset(
                    'assets/images/address.png',
                    width: 30,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      LoadingDialog.showLoadingDialog(context, 'Đang cập nhật dữ liệu lên hệ thống');
                      UserModel user = UserModel(
                          email: provider.curEmail,
                          name: fullname,
                          phone: phone,
                          address: address);
                      UserRepository().updateUser(provider.curUserId, user, () {
                        LoadingDialog.hideLoadingDialog();
                        Helper.newPage(context, const UserInfoScreen());
                        MsgDialog.showMsgDialog(context, 'Thông báo',
                            'Đã hoàn tất cập nhật thông tin người dùng');
                      }, () {
                        LoadingDialog.hideLoadingDialog();
                        MsgDialog.showMsgDialog(context, 'Lỗi',
                            'Đã xảy ra lỗi trong quán trình cập nhật thông tin');
                      });
                    }
                  },
                  child: const Text(style: TextStyle(fontSize: 20), 'Xác nhận'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Helper.newPage(context, const UserInfoScreen());
                  },
                  child: const Text(style: TextStyle(fontSize: 20), 'Hủy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
