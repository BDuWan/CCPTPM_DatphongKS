import 'package:booking_hotel/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/IntroScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Booking Hotel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(child: IntroScreen()));
  }
}
