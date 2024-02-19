import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:setik_eva/main/DataMenu.dart';
import 'package:setik_eva/main/Welcome.dart';
import 'MainNavigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "L I D Y A A - 2023",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/images/logook.png",
                width: 200,
                height: 200,
              )
            ],
          )
        ],
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, NavigationPage);
  }

  NavigationPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Welcome(),
        ),
        (route) => false);
  }
}
