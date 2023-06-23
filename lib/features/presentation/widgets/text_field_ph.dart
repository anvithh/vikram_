import 'package:flutter/material.dart';

class TextFieldWidgetPh extends StatelessWidget {
  final String info;
  final bool isPaasword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const TextFieldWidgetPh(
      {super.key,
      required this.info,
      required this.isPaasword,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone number",
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF5F626A),
          ),
        ),
        SizedBox(
          height: 55,
          width: 350,
          child: Row(
            children: [
              Expanded(
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
                    prefixIcon: Image.asset(
                      'assets/india.png',
                      width: 50,
                      height: 50,
                    ),
                    // Add any desired styling or customization for the text field
                  ),
                  validator: validator,
                  // Add any necessary validation or controller properties
                ),
              ),
              // const SizedBox(width: 5),
              // ElevatedButton(
              //   onPressed: () {
              //     // Add your button onPressed logic here
              //   },
              //   child: const Text(
              //     'Send OTP to verify',
              //     style: TextStyle(fontSize: 10),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
