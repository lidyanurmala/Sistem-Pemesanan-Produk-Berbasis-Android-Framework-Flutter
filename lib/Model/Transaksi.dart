class Transaksi {
  Transaksi(
      {required this.kd_pesanan,
      required this.tgl_transaksi,
      required this.nama_menu,
      required this.harga,
      required this.qty,
      required this.total_bayar});

  String kd_pesanan;
  String tgl_transaksi;
  String nama_menu;
  String harga;
  String qty;
  String total_bayar;

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        kd_pesanan: json["kd_pesanan"] ?? "",
        tgl_transaksi: json["tgl_transaksi"] ?? "",
        nama_menu: json["nama_menu"] ?? "",
        harga: json["harga"] ?? "",
        qty: json["qty"] ?? "",
        total_bayar: json["total_bayar"] ?? "",
      );
}
