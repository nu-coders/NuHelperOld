import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:front_end/components/about_us_button.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/button.dart';
import '../../components/text_field.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  get password => null;

  @override
  Widget build(BuildContext context) {
    var email;

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
            pressFunction: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const Text('Developed by:\n Bahaa\n Mohamed\n Yusuf'),
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
        ],
      ),
    );
  }
}
