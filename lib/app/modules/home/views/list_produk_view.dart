import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kasir_getx/app/data/produk.dart';
import 'package:kasir_getx/app/modules/home/controllers/home_controller.dart';

class ListProdukView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListProdukView'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.produk.length,
        itemBuilder: (_, i) {
          ProdukModel pm = controller.produk[i];
          return ExpansionTile(
            controlAffinity: ListTileControlAffinity.trailing,
            initiallyExpanded: true,
            textColor: Colors.black,
            iconColor: Colors.black,
            childrenPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            children: [
              ListTile(
                title: Text("Harga"),
                trailing: Text(pm.hargaProduk.toString()),
              ),
              ListTile(
                title: Text("Stok"),
                trailing: Text(pm.stokProduk.toString()),
              ),
            ],
            title: Text(pm.namaProduk!.capitalize!),
            trailing: IconButton(
              onPressed: () {
                ProdukTransaksiModel ptm = ProdukTransaksiModel(
                  hargaSatuan: pm.hargaProduk,
                  hargaTotal: pm.hargaProduk,
                  idProduk: pm.id,
                  namaProduk: pm.namaProduk,
                  qty: 1,
                );
                if (controller.keranjang
                        .indexWhere((element) => element.idProduk == pm.id) ==
                    -1) {
                  controller.tambahKeranjang(ptm);
                } else {
                  controller
                      .keranjang[controller.keranjang
                          .indexWhere((element) => element.idProduk == pm.id)]
                      .hargaTotal = controller
                          .keranjang[controller.keranjang.indexWhere(
                              (element) => element.idProduk == pm.id)]
                          .hargaTotal! +
                      pm.hargaProduk!;
                  controller
                      .keranjang[controller.keranjang
                          .indexWhere((element) => element.idProduk == pm.id)]
                      .qty = controller
                          .keranjang[controller.keranjang.indexWhere(
                              (element) => element.idProduk == pm.id)]
                          .qty! +
                      1;
                  controller.keranjang.refresh();
                }
                controller.totalHarga.value += pm.hargaProduk!;
                Get.back();
              },
              icon: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
