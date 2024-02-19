import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:flutter/material.dart';
import 'package:setik_eva/Repository/MenuRepo.dart';
import 'package:setik_eva/Repository/KeranjangRepo.dart';
import 'package:setik_eva/main/DataKeranjang.dart';

import '../Model/menu.dart';

class DataMenu extends StatefulWidget {
  final String nama_tf;
  const DataMenu({super.key, required this.nama_tf});

  @override
  State<DataMenu> createState() => _DataMenuState();
}

class _DataMenuState extends State<DataMenu> {
  bool add = false;
  String Qty = "1";

  late String nama = "";

  List<Menu> listMenu = [];
  MenuRepo repository = MenuRepo();
  KeranjangRepo repository2 = KeranjangRepo();

  getData() async {
    listMenu = await repository.getData();
    setState(() {});
  }

  postData(String idMenu, String qty) async {
    print(idMenu);
    bool respons = await repository2.postData(idMenu, qty);
    if (respons) {
      print("SUKSES");
    } else {
      print("FAIL");
    }
  }

  @override
  void initState() {
    getData();
    nama = widget.nama_tf;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Menu"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataKeranjang(nama_tf: nama)));
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Container(
        child: listMenu.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(25),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(
                  listMenu.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.grey.withOpacity(0.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 10.0)),
                                    Text(
                                      listMenu[index].nama_menu,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      height: 270,
                                      width: 270,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://apisetik.000webhostapp.com/uploads/${listMenu[index].gambar}'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.0,
                                    ),
                                    Text(
                                      "Rp. " + listMenu[index].harga,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      listMenu[index].deskripsi,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    InputQty(
                                      maxVal: 100,
                                      initVal: 1,
                                      steps: 1,
                                      minVal: 1,
                                      borderShape: BorderShapeBtn.circle,
                                      boxDecoration: const BoxDecoration(),
                                      minusBtn: const Icon(Icons.remove_circle,
                                          size: 24),
                                      plusBtn: const Icon(
                                        Icons.add_circle,
                                        size: 24,
                                      ),
                                      btnColor1: Colors.green,
                                      onQtyChanged: (val) {
                                        Qty = val.toString();

                                        if (kDebugMode) {
                                          print(val);
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        //Compare to:
                                        onPressed: (() {
                                          postData(
                                              listMenu[index]
                                                  .id_menu
                                                  .toString(),
                                              Qty);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DataKeranjang(
                                                        nama_tf: nama,
                                                      )));
                                        }),
                                        child: Text("Tambah Keranjang"))
                                  ],
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5.0,
                                blurRadius: 5.0,
                              )
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://apisetik.000webhostapp.com/uploads/${listMenu[index].gambar}',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0))),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6.0, right: 6.0),
                                child: Text(
                                  listMenu[index].nama_menu,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "Rp." + listMenu[index].harga,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
