class ProdukModel {
  String? id;
  String? namaProduk;
  int? hargaProduk;
  int? stokProduk;
  String? deskripsiProduk;
  ProdukModel({
    this.id,
    this.namaProduk,
    this.hargaProduk,
    this.stokProduk,
    this.deskripsiProduk,
  });
}

class ProdukTransaksiModel {
  String? idProduk;
  int? hargaSatuan;
  int? hargaTotal;
  int? qty;
  String? namaProduk;
  ProdukTransaksiModel({
    this.idProduk,
    this.hargaSatuan,
    this.hargaTotal,
    this.qty,
    this.namaProduk,
  });
}

class TransaksiModel {
  String? idTransaksi;
  int? totalHarga;
  int? bayar;
  int? kembalian;
  List<ProdukTransaksiModel>? daftarBarang;
  TransaksiModel({
    this.idTransaksi,
    this.totalHarga,
    this.bayar,
    this.kembalian,
    this.daftarBarang,
  });
}
