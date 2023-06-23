import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikram/features/presentation/cubit/credentials/cubit/credential_cubit.dart';
import 'package:vikram/features/presentation/pages/agent.dart';
import 'package:vikram/features/presentation/pages/both.dart';
import 'package:vikram/features/presentation/pages/chat_interface.dart';
import 'package:vikram/features/presentation/pages/login.dart';
import 'package:vikram/features/presentation/pages/onboarding_screen.dart';
import 'package:vikram/features/presentation/pages/personal.dart';
// import 'package:vikram/features/presentation/pages/onboarding_screen.dart';
import 'package:vikram/features/presentation/pages/register.dart';
import 'injection_container.dart' as di;
import 'package:vikram/on_generate_route.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CredentialCubit>(create: (_) => di.sl<CredentialCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: OnGenerateRoute.route, 
        initialRoute: "/",
        routes: {
          "/": (context) {
            return const PersonalPage();
          }
        },
      ),
    );
  }
}
