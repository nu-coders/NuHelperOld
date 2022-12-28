import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:front_end/components/button.dart';

import '../components/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade50,
        body: Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 300,
              ),
            ),
            const SizedBox(
              height: 140,
            ),
            MyTextField(
                hintText: "your asian name ",
                obscureText: false,
                controller: email),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                hintText: "asian", obscureText: true, controller: email),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              text: "Login",
              color: Color.fromARGB(255, 62, 168, 255),
              a: () {
                AlertDialog(
                  title: Text("test"),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                      a: () {
                        
                        print(email.text);
                      },
                      text: "Register",
                      color: Color.fromARGB(255, 42, 93, 134)),
                ),
                Expanded(
                  child: MyButton(
                      a: () {
                        print("ge");
                      },
                      text: "Continue As Guest",
                      color: Colors.blue),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
