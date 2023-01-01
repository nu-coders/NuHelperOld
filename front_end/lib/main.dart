import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:front_end/backend/Tempfile.dart';
import 'package:front_end/backend/room_locator.dart';
import 'package:front_end/pages/inital_page.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  test();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const IntialPage(),
    );
  }
}
