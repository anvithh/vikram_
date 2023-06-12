import 'package:flutter/material.dart';
import 'package:vikram/features/presentation/pages/agent.dart';
import 'package:vikram/features/presentation/pages/both.dart';
import 'package:vikram/features/presentation/pages/onboarding_screen.dart';
import 'package:vikram/features/presentation/pages/personal.dart';
// import 'package:vikram/features/presentation/pages/onboarding_screen.dart';
import 'package:vikram/features/presentation/pages/register.dart';

import 'package:vikram/on_generate_route.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: OnGenerateRoute.route, 
      initialRoute: "/",
      routes: {
        "/": (context) {
          return const PersonalPage();
        }
      },
    );
  }
}
