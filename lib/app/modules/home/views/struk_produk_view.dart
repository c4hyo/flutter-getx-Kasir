import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kasir_getx/app/data/produk.dart';
import 'package:kasir_getx/app/modules/home/controllers/home_controller.dart';

class StrukProdukView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StrukProdukView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text("Daftar Barang"),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: controller.transaksiDetail.value.daftarBarang!.length,
              itemBuilder: (_, i) {
                ProdukTransaksiModel ptm =
                    controller.transaksiDetail.value.daftarBarang![i];
                return ListTile(
                  title: Text(ptm.namaProduk!),
                  subtitle: Text(ptm.hargaTotal.toString()),
                  trailing: Text(ptm.qty!.toString()),
                );
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            ListTile(
              title: Text("Total Harga"),
              trailing: Text(
                controller.transaksiDetail.value.totalHarga.toString(),
              ),
            ),
            ListTile(
              title: Text("Bayar"),
              trailing: Text(
                controller.transaksiDetail.value.bayar.toString(),
              ),
            ),
            ListTile(
              title: Text("Kembalian"),
              trailing: Text(
                controller.transaksiDetail.value.kembalian.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
