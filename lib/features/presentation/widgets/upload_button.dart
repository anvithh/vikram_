import 'package:flutter/material.dart';

class UploadButtonWidget extends StatelessWidget {
  final String content;
  final Color? color;
  final VoidCallback? tonTap;
  final Color? textColor;
  const UploadButtonWidget(
      {super.key, required this.content, required this.color, this.textColor, this.tonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: tonTap,
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
