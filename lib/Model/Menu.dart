class Menu {
  Menu({
    required this.id_menu,
    required this.nama_menu,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
    required this.kategori,
    required this.status,
  });

  String id_menu;
  String nama_menu;
  String harga;
  String deskripsi;
  String gambar;
  String kategori;
  String status;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id_menu: json["id_menu"],
        nama_menu: json["nama_menu"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
        kategori: json["kategori"],
        status: json["status"],
      );
}
