import 'package:flutter/material.dart';

class UploadButtonWidget extends StatelessWidget {
  final String content;
  final Color? color;
  final Color? textColor;
  const UploadButtonWidget(
      {super.key, required this.content, required this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color?>(color), // Change button color
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(100.0), // Change border circular radius
            ),
          ),
        ),
        child: Text(
          content,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
