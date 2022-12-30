import 'package:flutter/material.dart';
import 'package:front_end/components/login/button.dart';
import 'package:front_end/pages/register_screen.dart';

import '../components/login/text_field.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final email = TextEditingController();
  final password = TextEditingController();

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
                    CustomButton(
                      text: "Login",
                      color: const Color.fromARGB(255, 39, 187, 255),
                      pressFunction: () {},
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              pressFunction: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              text: "Register",
                              color: const Color.fromARGB(255, 45, 130, 199)),
                        ),
                        Expanded(
                          child: CustomButton(
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
