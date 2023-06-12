import 'package:flutter/material.dart';

class AddRulesPersonal extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
    final VoidCallback? tonPressed;

  const AddRulesPersonal({super.key, required this.color, required this.iconColor, this.tonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color),
      child: GestureDetector(
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: iconColor,
          ),
          color: Colors.black,
          onPressed: tonPressed,
        ),
      ),
    );
  }
}
