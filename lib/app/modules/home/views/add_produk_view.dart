import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kasir_getx/app/data/produk.dart';
import 'package:kasir_getx/app/modules/home/controllers/home_controller.dart';

class AddProdukView extends GetView<HomeController> {
  final nama = TextEditingController();
  final deskripsi = TextEditingController();
  final stok = TextEditingController();
  final harga = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddProdukView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            TextFormField(
              controller: nama,
              decoration: InputDecoration(
                hintText: "Nama Produk",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: stok,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Stok Produk",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: harga,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Harga Produk",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: deskripsi,
              decoration: InputDecoration(
                hintText: "Deskripsi Produk",
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (deskripsi.text.isNotEmpty ||
                    stok.text.isNotEmpty ||
                    harga.text.isNotEmpty ||
                    nama.text.isNotEmpty) {
                  ProdukModel pm = ProdukModel(
                    deskripsiProduk: deskripsi.text,
                    hargaProduk: int.parse(harga.text),
                    id: controller.generateCode(),
                    namaProduk: nama.text,
                    stokProduk: int.parse(stok.text),
                  );
                  controller.tambahProduk(pm);

                  Get.back();
                } else {
                  Get.snackbar("Peringatan", "Form harus di isi semua");
                }
              },
              child: Text("Tambah Produk"),
            ),
          ],
        ),
      ),
    );
  }
}
