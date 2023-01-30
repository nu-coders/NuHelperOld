import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:front_end/backend/shared_variables.dart';
import 'package:front_end/components/about_us/about_us_button.dart';
import 'package:front_end/components/tm/cart.dart';
import 'package:front_end/pages/login_screen.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final SharedVariables variables = Get.put(SharedVariables());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.6,
              widthFactor: 0.85,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
          ),
          AboutUsButton(
            text: "Contact Us",
            icon: Icons.contact_mail,
            pressFunction: () async {
              final url = Uri.parse("mailto:contact@nucoders.dev");
              if (!await launchUrl(url)) {
                throw 'Could not launch $url';
              }
            },
          ),
          AboutUsButton(
            text: "Devs",
            icon: Icons.code,
            pressFunction: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Developed by:'),
                content: const Text(' Bahaa\n Mohamed\n Yusuf'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
          AboutUsButton(
            text: "Our Website",
            icon: Icons.web,
            pressFunction: () async {
              final url = Uri.parse("https://nucoders.dev");
              if (!await launchUrl(url)) {
                throw 'Could not launch $url';
              }
            },
          ),
          AboutUsButton(
            text: "Report Bug",
            icon: Icons.bug_report,
            pressFunction: () async {
              final url = Uri.parse("https://nucoders.dev/bug");
              if (!await launchUrl(url)) {
                throw 'Could not launch $url';
              }
            },
          ),
          
          FirebaseAuth.instance.currentUser?.uid == null
              ? AboutUsButton(
                  text: "Login",
                  icon: Icons.login,
                  pressFunction: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false),
                )
              : AboutUsButton(
                  text: "Logout",
                  icon: Icons.logout,
                  pressFunction: () => FirebaseAuth.instance.signOut())
        ],
      ),
    );
  }
}
