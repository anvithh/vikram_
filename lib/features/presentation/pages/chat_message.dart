import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class ChatMessage extends StatelessWidget {
  ChatMessage(
      {super.key,
      required this.text,
      required this.sender,
      required this.color,
      this.colorUser,
      this.colorBot,
      this.colorDay});

  final String text;
  final String sender;
  final Color color;
  final Color? colorUser;
  final Color? colorBot;
  final Color? colorDay;

//
  @override
  Widget build(BuildContext context) {
    Color containerColor;
    if (sender == "user") {
      containerColor = colorDay ?? const Color(0xFF161A27);
    } else {
      containerColor = const Color(0xFF252834);
    }
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        color: containerColor,

        // color: sender == "user" ? const Color(0xFF161A27) : const Color(0xFF252834),
        child: Row(
          children: [
            Image.asset(
              sender == "user"
                  ? "assets/user-circle.png"
                  : "assets/logo2_without_bg.png",
              width: 48,
              height: 48,
              color: color,
            ).box.p12.rounded.alignCenter.makeCentered(),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
