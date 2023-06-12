import 'package:flutter/material.dart';

class ContainerButtonWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? tonTap;
  const ContainerButtonWidget({super.key, required this.title, this.color, this.tonTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tonTap,
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: 300,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
