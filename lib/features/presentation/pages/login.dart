import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vikram/features/presentation/widgets/header.dart';

import '../../../const.dart';
import '../widgets/container_button.dart';
import '../widgets/text_field.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _tempLogin(Map<String, dynamic> formData) async {
    // var url = Uri.parse("http://10.0.2.2:8080/login");
    var url = Uri.parse("https://server.vikrambots.in/login");

    var requestBody = '{"username":"${username.text}",'
        '"password":"${password.text}"}';

    var headers = {
      'Content-Type': 'application/json',
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 250,
            width: 250,
            color: Colors.white,
            child: Center(
              // Center the content vertically and horizontally
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Logging you in..",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );

    var response = await http.post(url, headers: headers, body: requestBody);
    Navigator.pop(context);

    print("THE REQUAET BODY FOR REQUEST::\n\n" + requestBody + "\n\n");
    print("\n\n\n\n\n\\n");
    print(response.body);
    if (response.statusCode != 200) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('User not registered'),
            content: const Text('Please enter valid username'),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Dismiss the dialog
                  Navigator.pushNamed(context, PageConstant.loginPage);
                },
              ),
            ],
          );
        },
      );
    }
    if (response.statusCode == 200) {
      // final responseData = json.decode(response.body);
      // final message = responseData['message'];
      // if (message == 'Login Successful') {
      //   Navigator.pushNamed(context, PageConstant.chatPage);
      // }
      if (response.body == 'Incorrect password') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Incorrect password!'),
              content: const Text('Please enter the correct password.'),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); // Dismiss the dialog
                    Navigator.pushNamed(context, PageConstant.loginPage);
                  },
                ),
              ],
            );
          },
        );
      }
      if (response.body != 'Incorrect password') {
        final responseData = json.decode(response.body);
        final message = responseData['message'];
        if (message == 'Login Successful') {
          Navigator.pushNamed(context, PageConstant.chatPage);
        }
      }
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const HeaderWidget(),
              const SizedBox(
                height: 90,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFieldWidget(
                info: "VIKRAM Username",
                isPaasword: false,
                controller: username,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }

                  final RegExp alphanumericRegExp =
                      RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$');

                  if (!alphanumericRegExp.hasMatch(value)) {
                    return 'Please enter a valid value. It must start with a letter and contain only alphanumeric characters.';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                info: "Password",
                isPaasword: true,
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }

                  final RegExp passwordRegExp =
                      RegExp(r'^[a-zA-Z0-9@#$%^&+=!]*$');

                  if (!passwordRegExp.hasMatch(value)) {
                    return 'Please enter a valid password';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {},
                child: ContainerButtonWidget(
                    title: "Login",
                    color: Colors.blue,
                    tonTap: () {
                      if (_formKey.currentState!.validate()) {
                        username.text = username.text.substring(0, 1).toUpperCase() +
                            username.text.substring(1);
                        Map<String, String?> formData = {
                          "username": (username.text),
                          "password": (password.text)
                        };
                        _tempLogin(formData);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
