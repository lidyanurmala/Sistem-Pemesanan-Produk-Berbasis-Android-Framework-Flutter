import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:setik_eva/main/DataMenu.dart';
import 'Home.dart';
import 'DataTransaksi.dart';

class MainNavigation extends StatefulWidget {
  final String nama_tf;
  const MainNavigation({super.key, required this.nama_tf});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late String nama = "";
  int CurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    nama = widget.nama_tf;
  }

  @override
  Widget build(BuildContext context) {
    final _pageOption = [
      Home(),
      DataMenu(nama_tf: nama),
    ];
    return Scaffold(
      body: _pageOption[CurrentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.brown[400],
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.menu, title: 'Menu'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            CurrentIndex = i;
          });
        },
      ),
    );
  }
}
