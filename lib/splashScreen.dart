import 'package:ecommerceapi/auth_screen/Register_screen.dart';
import 'package:ecommerceapi/homescrren.dart';
import 'package:ecommerceapi/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
            ),
          )),
          Text('Developoed by Dart ')
        ],
      ),
    );
  }
}
