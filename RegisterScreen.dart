import 'package:booking_hotel/Helper.dart';
import 'package:booking_hotel/Screens/LoginScreen.dart';
import 'package:booking_hotel/blocs/auth_bloc.dart';
import 'package:booking_hotel/dialog/LoadingDialog.dart';
import 'package:booking_hotel/dialog/MsgDialog.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng kí')),
      body: RegisterBody(),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String email = '';
  String fullname = '';
  String phone = '';
  String password = '';
  String repassword = '';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = new AuthBloc();
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
                height: 10,
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
                    return 'Bạn chưa nhập email';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Nhập Email',
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
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    repassword = value;
                  });
                },
                validator: (value) {
                  repassword = value!;
                  if (repassword.isEmpty) {
                    return 'Bạn chưa nhập lại mật khẩu';
                  }
                  if (repassword != password) {
                    return 'Mật khẩu nhập lại không khớp';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Retype Password',
                    hintText: 'Nhập lại mật khẩu',
                    prefixIcon: Image.asset(
                      'assets/images/re_pass.png',
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
                    authBloc.Register(email, password, fullname, phone, () {
                      LoadingDialog.hideLoadingDialog(context);
                      Helper.nextPage(context, const LoginScreen());
                      MsgDialog.showMsgDialog(context, "Đăng kí thành công",
                          "Vui lòng đăng nhập để tiếp tục sử dụng dịch vụ");
                    }, (msg) {
                      LoadingDialog.hideLoadingDialog(context);
                      MsgDialog.showMsgDialog(context, "Errol", msg);
                    });
                  }
                },
                child: const Text(style: TextStyle(fontSize: 20), 'Đăng kí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
