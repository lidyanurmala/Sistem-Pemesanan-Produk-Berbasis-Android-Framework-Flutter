import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../Widget/BestSellerWidget.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "P A N G E S T U's Caffe",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Menu Best Seller",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          BestSellerWidget(),
        ],
      ),
    );
  }
}
