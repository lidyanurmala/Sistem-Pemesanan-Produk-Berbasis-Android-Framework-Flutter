import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:setik_eva/main/DataTransaksi.dart';

import '../Model/Transaksi.dart';

class TransaksiRepo {
  final _baseUrl = 'https://apisetik.000webhostapp.com';

  Future getData(String kd_pesanan) async {
    try {
      final response =
          await http.post(Uri.parse("$_baseUrl/API/tampil_pesanan.php"),
              headers: <String, String>{"Accept": "application/json"},
              body: jsonEncode(<String, String>{
                "kd": kd_pesanan,
              }));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        Iterable transaksi = it.map((e) => Transaksi.fromJson(e)).toList();
        print(transaksi);
        return transaksi;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future TambahPesanan(String kd_pesanan, String total_bayar) async {
    try {
      final response = await http.post(
          Uri.parse("$_baseUrl/API/tambah_pesanan.php"),
          headers: <String, String>{"Accept": "application/json"},
          body: jsonEncode(<String, String>{
            "kd_pesanan": kd_pesanan,
            "total_bayar": total_bayar
          }));

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

  Future tambahItem(String kd_pesanan, String id_menu, String qty) async {
    try {
      final response = await http.post(
          Uri.parse("$_baseUrl/API/tambah_item.php"),
          headers: <String, String>{"Accept": "application/json"},
          body: jsonEncode(<String, String>{
            "pesanan_kd": kd_pesanan,
            "menu_id": id_menu,
            "qty": qty
          }));

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
}
