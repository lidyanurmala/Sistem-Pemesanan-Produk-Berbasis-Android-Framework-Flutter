import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/menu.dart';

class MenuRepo {
  final _baseUrl =
      'https://apisetik.000webhostapp.com/API/tampil_semua_data.php';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        Iterable menu = it.map((e) => Menu.fromJson(e)).toList();
        return menu;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
