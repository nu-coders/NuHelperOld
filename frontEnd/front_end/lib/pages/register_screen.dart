import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/components/login/button.dart';
import 'package:front_end/pages/home_page.dart';
import '../components/login/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();

  final password = TextEditingController();

  final passwordConfirmation = TextEditingController();

  void register() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successful Registration"),
        ),
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Email"),
          ),
        );
      } else if (error.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Weak Password"),
          ),
        );
      } else if (error.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email Already in Use"),
          ),
        );
      }
      print(error.code);
      print("errrooooooooooooooooooooooo/register");
      Navigator.pop(context);
    }
  }

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
                        controller: passwordConfirmation),
                    CustomButton(
                      text: "Register",
                      color: const Color.fromARGB(255, 39, 187, 255),
                      pressFunction: () {
                        if (password.text.isNotEmpty && email.text.isNotEmpty) {
                          if (password.text == passwordConfirmation.text) {
                            register();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Password and Password Confirmation are not the same"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Fill Password/Email Field"),
                            ),
                          );
                        }
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              pressFunction: () {
                                Navigator.of(context).pop();
                              },
                              text: "Registered?",
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
