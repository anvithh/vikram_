import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 175,
          width: double.infinity,
          color: const Color(0xFF161A27),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Replace the following widget with your logo

                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0.0),
                  child: Image.asset(
                    'assets/logo2.jpg',
                    height: 100,
                    width: 100, // Replace with the path to your logo image
                  ),
                ),
                // const Text(
                //   "Your Personal Bot!",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                  child: Text(
                    "V.I.K.R.A.M",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
