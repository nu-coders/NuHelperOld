import 'package:flutter/material.dart';
import 'package:front_end/pages/login_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
