import 'package:booking_hotel/Helper.dart';
import 'package:booking_hotel/Screens/ChangePassScreen.dart';
import 'package:booking_hotel/Screens/IntroScreen.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Helper.nextPage(context, const ChangePassScreen());
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(300, 65)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all(Colors
                        .lightBlue[200])
                    ),
                child: const Text(
                  'Đổi mật khẩu',
                  style: TextStyle(fontSize: 25, color: Colors.black87),
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Helper.newPage(context, const IntroScreen());
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(300, 65)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue[200])),
                child: const Text(
                  'Đăng xuất',
                  style: TextStyle(fontSize: 25, color: Colors.black87),
                ))
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
        currentIndex: 3,
      ),
    );
  }
}
