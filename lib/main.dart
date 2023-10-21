import 'package:ecommerceapi/auth_screen/Auth_cubit/auth_cubit.dart';
import 'package:ecommerceapi/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: splashScreen(),
      ),
    );
  }
}
