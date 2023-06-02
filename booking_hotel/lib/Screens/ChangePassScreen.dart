import 'package:booking_hotel/dialog/LoadingDialog.dart';
import 'package:booking_hotel/dialog/MsgDialog.dart';
import 'package:booking_hotel/fire_base/fire_base_auth.dart';
import 'package:flutter/material.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  String newpassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thay đổi mật khẩu')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 20),
            onChanged: (value) {
              setState(() {
                newpassword = value;
              });
            },
            decoration: InputDecoration(
                labelText: 'Mật khẩu mới',
                hintText: 'Nhập mật khẩu mới vào đây',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 1, 0, 1)),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (newpassword.isEmpty) {
                MsgDialog.showMsgDialog(
                    context, 'Thông báo', 'Bạn chưa nhập mật khẩu mới');
              } else {
                LoadingDialog.showLoadingDialog(context, 'Vui lòng đợi');
                FireAuth().changePass(newpassword, () {
                  LoadingDialog.hideLoadingDialog();
                  MsgDialog.showMsgDialog(
                      context, 'Thông báo', 'Đã đổi mật khẩu thành công');
                }, () {
                  LoadingDialog.hideLoadingDialog();
                  MsgDialog.showMsgDialog(context, 'Lỗi', 'Vui lòng thử lại');
                });
              }
            },
            child: const Text(
              'Đổi mật khẩu',
              style: TextStyle(fontSize: 25, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
