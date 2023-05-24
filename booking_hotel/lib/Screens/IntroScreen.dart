import 'package:flutter/material.dart';
import '../Helper.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const TextStyle1 = TextStyle(
        fontSize: 40,
        height: 2,
        color: Colors.blue,
        fontWeight: FontWeight.bold);
    const TextStyle2 = TextStyle(
        fontSize: 25,
        height: 2,
        color: Colors.red,
        decoration: TextDecoration.underline);
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
            ),
            SizedBox(
              height: 0.5 * size.height,
              width: size.width,
              child: Image.asset(
                'assets/images/Anh_KS.jpg',
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0.4 * size.height,
              child: Container(
                height: 0.3 * size.height,
                width: size.width,
                color: Colors.white,
                alignment: Alignment.center,
                child: const Text(
                  style: TextStyle1,
                  'Chào mừng đến với Nhóm 11',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 0.3 * size.height,
                width: size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Helper.nextPage(context, LoginScreen());
                      },
                      icon: const Icon(Icons.login),
                      label: const Text(style: TextStyle2, 'Đăng nhập'),
                    ),
                    TextButton.icon(
                      onPressed:(){
                        Helper.nextPage(context, RegisterScreen());
                      },
                      icon: const Icon(Icons.app_registration),
                      label: const Text(style: TextStyle2, 'Đăng kí'),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}