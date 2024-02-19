import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setik_eva/main/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pangestu Caffe',
      theme: ThemeData(
        textTheme:
            Theme.of(context).textTheme.apply(bodyColor: Color(0xFF535343)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
