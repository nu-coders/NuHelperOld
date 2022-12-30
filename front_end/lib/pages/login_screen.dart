import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:front_end/components/login/button.dart';
import 'package:front_end/pages/register_screen.dart';

import '../components/login/text_field.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (error) {
      if (error.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wrong email/password combination."),
          ),
        );
      } else if (error.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wrong email/password combination."),
          ),
        );
      } else if (error.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email address is invalid."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login failed. Please try again."),
          ),
        );
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        // resizeToAvoidBottomInset: false,
        child: Column(
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
                      pressFunction: () {
                        login();
                      },
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
