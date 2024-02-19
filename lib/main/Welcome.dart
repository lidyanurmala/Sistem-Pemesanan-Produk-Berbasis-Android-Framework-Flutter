import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:setik_eva/main/DataMenu.dart';
import 'package:setik_eva/main/Home.dart';
import 'package:setik_eva/main/MainNavigation.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final nama_tf = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nama_tf,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Input Nama, Take Away/Makan ditempat"),
              ),
              ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainNavigation(
                                nama_tf: nama_tf.text,
                              )));
                }),
                child: Text("Lihat Menu"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
