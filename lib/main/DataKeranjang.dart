import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:setik_eva/Model/Keranjang.dart';
import 'package:setik_eva/Model/Menu.dart';
import 'package:setik_eva/Model/Transaksi.dart';
import 'package:setik_eva/Repository/KeranjangRepo.dart';
import 'package:setik_eva/Repository/TransaksiRepo.dart';
import 'package:setik_eva/main/DataMenu.dart';
import 'package:setik_eva/main/DataTransaksi.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

import 'package:setik_eva/main/Welcome.dart';

class DataKeranjang extends StatefulWidget {
  final String nama_tf;
  const DataKeranjang({super.key, required this.nama_tf});

  @override
  State<DataKeranjang> createState() => _DataKeranjangState();
}

class _DataKeranjangState extends State<DataKeranjang> {
  List<Keranjang> listKeranjang = [];
  KeranjangRepo repository = KeranjangRepo();
  late String nama = "";
  late int total = 0;

  Future getData() async {
    await Future.delayed(Duration(milliseconds: 500));

    listKeranjang = await repository.getData();

    total = 0;

    for (var list in listKeranjang) {
      total = total + (int.parse(list.harga)) * (int.parse(list.qty));
      // print("list" + list.harga + "*" + list.qty);
    }
    // print(total);
    setState(() {});
  }

  TransaksiRepo transaksi = TransaksiRepo();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void EditData(String id_keranjang, String qty) async {
    await KeranjangRepo().EditData(id_keranjang, qty);
  }

  void tambahPesanan() async {
    String kodeP = randomAlphaNumeric(8);
    bool respons = await transaksi.TambahPesanan(kodeP, total.toString());

    if (respons) {
      late bool respons2;
      for (var i = 0; i < listKeranjang.length; i++) {
        respons2 = await transaksi.tambahItem(
            kodeP, listKeranjang[i].id_menu, listKeranjang[i].qty);
      }
      if (respons2) {
        bool respons3 = await repository.HapusSemuaKeranjang();
        if (respons3) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DataTransaksi(nama_tf: widget.nama_tf, kd_pesanan: kodeP),
                  maintainState: true),
              ((route) => false));
        } else {
          print("FAIL");
        }
      } else {
        print("FAIL");
      }
    } else {
      print("FAIL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Keranjang"),
      ),
      body: listKeranjang.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: getData,
              child: ListView.builder(
                  itemCount: listKeranjang.length,
                  itemBuilder: (context, index) {
                    return listKeranjang.isEmpty
                        ? Text("Belum Ada Keranjang")
                        : Container(
                            margin: EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 5.0,
                              child: Row(
                                children: <Widget>[
                                  Image.network(
                                    "https://apisetik.000webhostapp.com/uploads/${listKeranjang[index].gambar}",
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    width: 220,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listKeranjang[index].nama_menu,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Rp. ${listKeranjang[index].harga}",
                                          style: TextStyle(
                                              color: Colors.orange.shade700,
                                              fontSize: 16),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: (() async {
                                                  await repository.HapusData(
                                                      listKeranjang[index]
                                                          .id_keranjang);
                                                  setState(() {
                                                    getData();
                                                  });
                                                }),
                                                icon: const Icon(Icons.delete))
                                          ],
                                        ),
                                        InputQty(
                                          maxVal: 100,
                                          initVal: int.parse(
                                              listKeranjang[index].qty),
                                          steps: 1,
                                          minVal: 1,
                                          borderShape: BorderShapeBtn.circle,
                                          boxDecoration: const BoxDecoration(),
                                          minusBtn: const Icon(
                                              Icons.remove_circle,
                                              size: 24),
                                          plusBtn: const Icon(
                                            Icons.add_circle,
                                            size: 24,
                                          ),
                                          btnColor1: Colors.green,
                                          onQtyChanged: (val) {
                                            EditData(
                                                listKeranjang[index]
                                                    .id_keranjang,
                                                val.toString());
                                            getData();

                                            // api update qty(id_keranjang, qty)
                                            // listkeranjang[index].id_keranjang
                                            // val
                                            if (kDebugMode) {
                                              print(val);
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  }),
            ),
      bottomNavigationBar: Container(
        height: 50,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 30,
            ),
            Text("Total: $total"),
            new SizedBox(
              height: 50,
              width: 215,
              child: ElevatedButton(
                  onPressed: () {
                    tambahPesanan();
                  },
                  child: Text("Check Out")),
            )
          ],
        ),
      ),
    );
  }
}
