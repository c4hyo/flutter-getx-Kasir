import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kasir_getx/app/data/produk.dart';
import 'package:kasir_getx/app/modules/home/controllers/home_controller.dart';

class TransaksiProdukView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransaksiProdukView'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.transaksi.length,
        itemBuilder: (_, i) {
          TransaksiModel tm = controller.transaksi[i];
          return ListTile(
            onTap: () {
              controller.goDetailTransaksi(tm);
            },
            title: Text(tm.idTransaksi!),
            trailing: Text(
              tm.totalHarga.toString(),
            ),
          );
        },
      ),
    );
  }
}
