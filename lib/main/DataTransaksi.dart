import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:setik_eva/Model/Keranjang.dart';
import 'package:setik_eva/Model/Transaksi.dart';
import 'package:setik_eva/Repository/KeranjangRepo.dart';
import 'package:setik_eva/Repository/TransaksiRepo.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import 'Welcome.dart';

class DataTransaksi extends StatefulWidget {
  final String nama_tf;
  final String kd_pesanan;
  const DataTransaksi(
      {super.key, required this.nama_tf, required this.kd_pesanan});

  @override
  State<DataTransaksi> createState() => _DataTransaksiState();
}

class _DataTransaksiState extends State<DataTransaksi> {
  List<Transaksi> listPesanan = [];
  TransaksiRepo repository = TransaksiRepo();
  String total = "";
  String tgl_transaksi = "";

  late String nama = "";

  getData() async {
    print(widget.kd_pesanan);
    listPesanan = await repository.getData(widget.kd_pesanan);
    total = listPesanan[0].total_bayar;
    tgl_transaksi = listPesanan[0].tgl_transaksi;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    startTime();
    super.initState();
  }

  startTime() async {
    var _duration = Duration(seconds: 10);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Text(
              "Pangestu Catering & Caffe",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("==============================="),
            Text(
              "Tanggal  : $tgl_transaksi",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "Nama Konsumen : ${widget.nama_tf}",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text("Kode Pesanan : ${widget.kd_pesanan}"),
            Text("=========================="),
            Container(
              width: 400,
              height: 400,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: ListView.builder(
                  itemCount: listPesanan.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                          "${listPesanan[index].nama_menu} ..........................."),
                      trailing: Text(
                          "@${listPesanan[index].harga}    x ${listPesanan[index].qty}"),
                    );
                  }),
            ),
            Text(
                "-------------------------------------------------------------------------------------"),
            Text(
              "Total: Rp.${total.toString()}",
              textAlign: TextAlign.right,
            ),
            Text("Struk dibawa ke kasir untuk pembayaran"),
          ],
        ),
      ),
    );
  }
}
