import 'package:flutter/material.dart';
import 'package:vikram/features/presentation/pages/personal.dart';
import 'package:vikram/features/presentation/widgets/container_button.dart';
// import 'package:vikram/features/presentation/pages/onboarding_screen.dart';
import 'package:vikram/features/presentation/widgets/header.dart';
import 'package:vikram/features/presentation/widgets/text_field.dart';
import 'package:vikram/features/presentation/widgets/text_field_ph.dart';

import '../../../const.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPersonalSelected = false;
  bool isProfessionalSelected = false;
  bool isBothSelected = false;

  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            const TextFieldWidget(info: "Full Name", isPaasword: false),
            const SizedBox(
              height: 20,
            ),
            const TextFieldWidget(info: "Full Name", isPaasword: false),
            const SizedBox(
              height: 20,
            ),
            const TextFieldWidgetPh(info: "Phone Number", isPaasword: false),
            const SizedBox(
              height: 20,
            ),
            const TextFieldWidget(info: "OTP", isPaasword: false),
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
                  if (isPersonalSelected) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConstant.personalPage, (route) => false);
                  }
                  if (isProfessionalSelected) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConstant.agentPage, (route) => false);
                  }
                  if(isBothSelected){
                    Navigator.pushNamedAndRemoveUntil(context, PageConstant.bothPage, (route) => false);
                  }
                  print("Register button tapped!");
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
