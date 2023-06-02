import 'package:booking_hotel/Screens/HomeScreen.dart';
import 'package:booking_hotel/fire_base/fire_base_auth.dart';
import 'package:flutter/material.dart';
import '../Helper.dart';
import '../providers/provider.dart';
import 'RegisterScreen.dart';
import 'package:booking_hotel/dialog/LoadingDialog.dart';
import 'package:booking_hotel/dialog/MsgDialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: const LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String email = '';
  String password = '';
  final _formkey = GlobalKey<FormState>();
  get curUID => curUID;
  @override
  Widget build(BuildContext context) {
    FireAuth authBloc = FireAuth();
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/Anh_KS.jpg',
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  email = value!;
                  if (email.isEmpty) {
                    return 'Bạn chưa nhập Email';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Nhập email',
                    prefixIcon: Image.asset(
                      'assets/images/email.png',
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
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) {
                  password = value!;
                  if (password.isEmpty) {
                    return 'Bạn chưa nhập mật khẩu';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Nhập mật khẩu',
                    prefixIcon: Image.asset(
                      'assets/images/password-icon-1.png',
                      width: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    LoadingDialog.showLoadingDialog(context, 'Vui lòng đợi');
                    authBloc.SignIn(
                        email,
                        password,
                        (curUID) {
                          LoadingDialog.hideLoadingDialog();
                          MyProvider provider = context.read<MyProvider>();
                          provider.setCurUserId(curUID);
                          Helper.nextPage(context, const HomeScreen());
                        },
                        (msg) {
                          LoadingDialog.hideLoadingDialog();
                          MsgDialog.showMsgDialog(context, "Errol", msg);
                        });
                  }
                },
                child: const Text(style: TextStyle(fontSize: 20), 'Đăng nhập'),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  style: TextStyle(fontSize: 18, color: Colors.red),
                  'Bạn chưa có tài khoản?'),
              ElevatedButton(
                onPressed: () {
                  Helper.nextPage(context, RegisterScreen());
                },
                child:
                    const Text(style: TextStyle(fontSize: 20), 'Đăng kí ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
