import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/Keranjang.dart';

class KeranjangRepo {
  final _baseUrl = 'https://apisetik.000webhostapp.com/API/';

  Future getData() async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}tampil_keranjang.php"));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        Iterable keranjang = it.map((e) => Keranjang.fromJson(e)).toList();
        return keranjang;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String idMenu, String qty) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://apisetik.000webhostapp.com/API/tambah_keranjang.php"),
          headers: <String, String>{"Accept": "application/json"},
          body: jsonEncode(<String, String>{"id": idMenu, "qty": qty}));

      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future HapusData(String id_keranjang) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://apisetik.000webhostapp.com/API/hapus_keranjang.php"),
          headers: <String, String>{"Accept": "application/json"},
          body: jsonEncode(<String, String>{"id_keranjang": id_keranjang}));
      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future EditData(String id_keranjang, String qty) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://apisetik.000webhostapp.com/API/ubah_keranjang.php"),
          headers: <String, String>{"Accept": "aplication/json"},
          body: jsonEncode(
              <String, String>{"id_keranjang": id_keranjang, "qty": qty}));
      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future HapusSemuaKeranjang() async {
    try {
      final response = await http.get(Uri.parse(
          "https://apisetik.000webhostapp.com/API/hapus_semua_keranjang.php"));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
