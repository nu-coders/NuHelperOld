import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:front_end/components/button.dart';
import 'package:front_end/pages/home_page.dart';

import '../components/text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirnation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade50,
        body: Column(
          children: [
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.70,
                widthFactor: 0.85,
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Column(
                  children: [
                    MyTextField(
                        hintText: "Your Email",
                        obscureText: false,
                        controller: email),
                    MyTextField(
                        hintText: "Your Password",
                        obscureText: true,
                        controller: password),
                    MyTextField(
                        hintText: "Re-enter Your Password",
                        obscureText: true,
                        controller: passwordConfirnation),
                    MyButton(
                      text: "Register",
                      color: const Color.fromARGB(255, 39, 187, 255),
                      pressFunction: () {},
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(
                              pressFunction: () {
                                Navigator.of(context).pop();
                              },
                              text: "Registered ?",
                              color: const Color.fromARGB(255, 45, 130, 199)),
                        ),
                        Expanded(
                          child: MyButton(
                              pressFunction: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                    (Route<dynamic> route) => false);
                              },
                              text: "Continue As Guest",
                              color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
