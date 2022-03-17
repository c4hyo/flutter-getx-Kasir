import 'dart:math';

import 'package:get/get.dart';
import 'package:kasir_getx/app/data/produk.dart';
import 'package:kasir_getx/app/modules/home/bindings/home_binding.dart';
import 'package:kasir_getx/app/modules/home/views/struk_produk_view.dart';

class HomeController extends GetxController {
  final keranjang = <ProdukTransaksiModel>[].obs;
  final produk = <ProdukModel>[].obs;
  final transaksi = <TransaksiModel>[].obs;

  final totalHarga = 0.obs;
  final bayar = 0.obs;

  final transaksiDetail = TransaksiModel().obs;

  tambahProduk(ProdukModel pm) {
    produk.add(pm);
  }

  tambahKeranjang(ProdukTransaksiModel ptm) {
    keranjang.add(ptm);
  }

  tambahTransaksi(TransaksiModel tm) {
    transaksi.add(tm);
    keranjang.value = <ProdukTransaksiModel>[];
    keranjang.refresh();
  }

  goDetailTransaksi(TransaksiModel tm) {
    transaksiDetail.value = transaksiDetail(tm);
    Get.to(
      () => StrukProdukView(),
      binding: HomeBinding(),
    );
  }

  String generateCode() {
    // digunakan untuk mengenerate string,
    //contoh penggunaan pada generate code
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(8, (_) {
      return _chars.codeUnitAt(_rnd.nextInt(_chars.length));
    }));
  }
}
