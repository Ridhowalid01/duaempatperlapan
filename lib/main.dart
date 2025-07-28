import 'package:duaempatperlapan/ui/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main () {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '24/3=?',
      theme: ThemeData(scaffoldBackgroundColor: Colors.purple[200]),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
