import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikram/features/presentation/cubit/credentials/cubit/credential_cubit.dart';
import 'package:vikram/features/presentation/pages/personal.dart';
import 'package:vikram/features/presentation/widgets/container_button.dart';
// import 'package:vikram/features/presentation/pages/onboarding_screen.dart';
import 'package:vikram/features/presentation/widgets/header.dart';
import 'package:vikram/features/presentation/widgets/text_field.dart';
import 'package:vikram/features/presentation/widgets/text_field_ph.dart';

import 'package:http/http.dart' as http;

import '../../../const.dart';
import 'onboarding_screen.dart';
import 'onboarding_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPersonalSelected = false;
  bool isProfessionalSelected = false;
  bool isBothSelected = false;

  TextEditingController _name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController vbot = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController agentBott = TextEditingController();

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }

    return text[0].toUpperCase() + text.substring(1);
  }

  Future<void> _tempRegistration(Map<String, dynamic> formData) async {
    // var url = Uri.parse("http://10.0.2.2:8080/register");
    var url = Uri.parse("https://server.vikrambots.in/register");

    var requestBody =
        '{"username":${vbot.text != "" ? '"${vbot.text}"' : 'null'},'
        '"password":"${password.text}",'
        '"phone":"${phone.text}",'
        '"email_id":"${email.text}",'
        '"name":"${_name.text}",'
        '"business_username": ${agentBott.text != "" ? '"${agentBott.text}"' : 'null'}}';

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
                    "Creating your account..",
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
            title: const Text('Registration Failed'),
            content: const Text('Please register once again'),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Dismiss the dialog
                  Navigator.pushNamed(context, PageConstant.registerPage);
                },
              ),
            ],
          );
        },
      );
      // Navigator.pushNamed(context, PageConstant.onBoarding);
    }
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final message = responseData['message'];
      if (message == 'Account created successfully') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Succesfully Registered!'),
              content: const Text('Please login to continue'),
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
        // Navigator.pushNamed(context, PageConstant.loginPage);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                child: Text(
                  'Register your VBot',
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
                info: "Full Name",
                isPaasword: false,
                controller: _name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name cannot be empty!';
                  }
                  final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');
                  if (!nameRegExp.hasMatch(value)) {
                    return 'Please enter a valid full name (only letters)';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                info: "Email",
                isPaasword: false,
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }

                  final RegExp emailRegExp = RegExp(
                    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
                  );

                  if (!emailRegExp.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidgetPh(
                info: "Phone Number",
                isPaasword: false,
                controller: phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }

                  final RegExp phoneRegExp = RegExp(r'^[6-9]\d{9}$');

                  if (!phoneRegExp.hasMatch(value)) {
                    return 'Please enter a valid Indian phone number';
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
              const SizedBox(height: 16),
              const Text(
                "Purpose of Bot:",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF5F626A),
                ),
              ),
              SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Theme(
                        data: ThemeData(
                          checkboxTheme: const CheckboxThemeData(
                            shape: CircleBorder(),
                          ),
                        ),
                        child: CheckboxListTile(
                          title: const Text(
                            'Personal',
                            style: TextStyle(
                              color: Color(0xFF5F626A),
                            ),
                          ),
                          value: isPersonalSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isPersonalSelected = newValue ?? false;
                              isProfessionalSelected = false;
                              isBothSelected =
                                  false; // Unselect the other checkbox
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.blue,
                          tileColor: Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Theme(
                        data: ThemeData(
                          checkboxTheme: const CheckboxThemeData(
                            shape: CircleBorder(),
                          ),
                        ),
                        child: CheckboxListTile(
                          title: const Text(
                            'Agent',
                            style: TextStyle(
                              color: Color(0xFF5F626A),
                            ),
                          ),
                          value: isProfessionalSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isProfessionalSelected = newValue ?? false;
                              isPersonalSelected = false;
                              isBothSelected =
                                  false; // Unselect the other checkbox
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.blue,
                          tileColor: Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Theme(
                        data: ThemeData(
                          checkboxTheme: const CheckboxThemeData(
                            shape: CircleBorder(),
                          ),
                        ),
                        child: CheckboxListTile(
                          title: const Text(
                            'Both Personal and Agent',
                            style: TextStyle(
                              color: Color(0xFF5F626A),
                            ),
                          ),
                          value: isBothSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isBothSelected = newValue ?? false;
                              isPersonalSelected = false;
                              isProfessionalSelected =
                                  false; // Unselect the other checkbox
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.blue,
                          tileColor: Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ),
                    if (isPersonalSelected)
                      Column(
                        children: [
                          const Text(
                            "Personal Bot ID  (_vik)",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF5F626A),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 350, // Set the desired width
                            height: 55, // Set the desired height,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Text area',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),

                                // Add any desired styling or customization for the text field
                              ),
                              controller: vbot,
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
                              // Add any necessary validation or controller properties
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    if (isProfessionalSelected)
                      Column(
                        children: [
                          const Text(
                            "Agent Bot ID  (_b_vik)",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF5F626A),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 350, // Set the desired width
                            height: 55, // Set the desired height,
                            child: TextFormField(
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
                              controller: agentBott,
                              decoration: InputDecoration(
                                hintText: 'Text area',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                // Add any desired styling or customization for the text field
                              ),
                              // Add any necessary validation or controller properties
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    if (isBothSelected)
                      Column(
                        children: [
                          const Text(
                            "Personal Bot ID  (_vik)",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF5F626A),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 350, // Set the desired width
                            height: 55, // Set the desired height,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a value';
                                }

                                final RegExp alphanumericRegExp =
                                    RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$');

                                if (!alphanumericRegExp.hasMatch(value)) {
                                  return 'Please enter a valid username containing only Alphanumeric characters.';
                                }

                                return null;
                              },
                              controller: vbot,
                              decoration: InputDecoration(
                                hintText: 'Text area',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                // Add any desired styling or customization for the text field
                              ),
                              // Add any necessary validation or controller properties
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Agent Bot ID  (_b_vik)",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF5F626A),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 350, // Set the desired width
                            height: 55, // Set the desired height,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a value';
                                }

                                final RegExp alphanumericRegExp =
                                    RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$');

                                if (!alphanumericRegExp.hasMatch(value)) {
                                  return 'Please enter a valid password.';
                                }

                                return null;
                              },
                              controller: agentBott,
                              decoration: InputDecoration(
                                hintText: 'Text area',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                // Add any desired styling or customization for the text field
                              ),
                              // Add any necessary validation or controller properties
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: ContainerButtonWidget(
                  title: "Register",
                  color: Colors.blue,
                  tonTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (isPersonalSelected) {
                        vbot.text = vbot.text.substring(0, 1).toUpperCase() +
                            vbot.text.substring(1);

                        Map<String, String?> formData = {
                          "username": (vbot.text),
                          "password": (password.text),
                          "phone": (phone.text),
                          "email_id": (email.text),
                          "name": (_name.text),
                          "business_username": null,
                        };
                        print(formData);
                        _tempRegistration(formData);
                      } else if (isProfessionalSelected) {
                        agentBott.text =
                            agentBott.text.substring(0, 1).toUpperCase() +
                                agentBott.text.substring(1);

                        Map<String, String?> formData = {
                          "username": null,
                          "password": (password.text),
                          "phone": (phone.text),
                          "email_id": (email.text),
                          "name": (_name.text),
                          "business_username": (agentBott.text),
                        };
                        print(formData);
                        _tempRegistration(formData);
                      } else if (isBothSelected) {
                        vbot.text = vbot.text.substring(0, 1).toUpperCase() +
                            vbot.text.substring(1);

                        agentBott.text =
                            agentBott.text.substring(0, 1).toUpperCase() +
                                agentBott.text.substring(1);

                        Map<String, String?> formData = {
                          "username": (vbot.text),
                          "password": (password.text),
                          "phone": (phone.text),
                          "email_id": (email.text),
                          "name": (_name.text),
                          "business_username": (agentBott.text),
                        };

                        print(formData);
                        _tempRegistration(formData);
                      }
                    }

                    // if (isPersonalSelected) {
                    //   Navigator.pushNamed(context, PageConstant.personalPage);
                    // }
                    // if (isProfessionalSelected) {
                    //   Navigator.pushNamed(context, PageConstant.agentPage);
                    // }
                    // if (isBothSelected) {
                    //   Navigator.pushNamed(context, PageConstant.bothPage);
                    // }
                    // _submitRegister();

                    // print("Register button tapped!");
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRegister() {
    BlocProvider.of<CredentialCubit>(context).submitRegister(body: {
      "name": _name,
      "phone": phone,
      "email": email,
      "password": password,
      "username": vbot,
      "business_username": ""
    });
  }
}
