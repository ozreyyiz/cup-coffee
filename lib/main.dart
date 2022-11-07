import 'package:cup_coffee/view/home/provider/amount_provider.dart';
import 'package:cup_coffee/view/home/provider/counter_provider.dart';
import 'package:cup_coffee/view/home/view/detail_page.dart';
import 'package:cup_coffee/view/home/view/home_page.dart';
import 'package:cup_coffee/view/landing/view/landing_page.dart';
import 'package:cup_coffee/view/order/view/confirm_page.dart';
import 'package:cup_coffee/view/shops/view/nearby_cafes_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AmountProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cup Coffee',
        theme: ThemeData(),
        home: LandingPage(),
      ),
    );
  }
}
