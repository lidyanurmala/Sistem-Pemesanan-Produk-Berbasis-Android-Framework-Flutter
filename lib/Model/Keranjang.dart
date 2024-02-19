class Keranjang {
  Keranjang({
    required this.id_keranjang,
    required this.id_menu,
    required this.gambar,
    required this.nama_menu,
    required this.harga,
    required this.qty,
  });

  String id_keranjang;
  String id_menu;
  String gambar;
  String nama_menu;
  String harga;
  String qty;

  factory Keranjang.fromJson(Map<String, dynamic> json) => Keranjang(
        id_keranjang: json["id_keranjang"] ?? "",
        id_menu: json["id_menu"] ?? "",
        gambar: json["gambar"] ?? "",
        nama_menu: json["nama_menu"] ?? "",
        harga: json["harga"] ?? "",
        qty: json["qty"] ?? "",
      );
}
