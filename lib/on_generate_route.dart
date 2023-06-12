import 'package:flutter/material.dart';
import 'package:vikram/const.dart';
import 'package:vikram/features/presentation/pages/agent.dart';
import 'package:vikram/features/presentation/pages/both.dart';
import 'package:vikram/features/presentation/pages/onboarding_screen.dart';
import 'package:vikram/features/presentation/pages/personal.dart';
import 'package:vikram/features/presentation/pages/register.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case "/":
        {
          return materialBuilder(widget: const OnboardingScreen());
        }

      case PageConstant.registerPage:
        {
          return materialBuilder(widget: const Register());
        }

        case PageConstant.personalPage:
        {
          return materialBuilder(widget: const PersonalPage());
        }

        case PageConstant.agentPage:
        {
          return materialBuilder(widget: const AgentPage());
        }

        case PageConstant.bothPage:
        {
          return materialBuilder(widget: const BothPage());
        }

      default:
        return materialBuilder(
          widget: const ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
