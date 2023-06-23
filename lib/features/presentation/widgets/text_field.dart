import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String info;
  final bool isPaasword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextFieldWidget(
      {super.key,
      required this.info,
      required this.isPaasword,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0,0,0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF5F626A),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 350, // Set the desired width
            height: 55, // Set the desired height,
            child: TextFormField(
              controller: controller,
              obscureText: isPaasword,
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
              validator: validator,
              // Add any necessary validation or controller properties
            ),
          ),
        ],
      ),
    );
  }
}
