import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kasir_getx/app/data/produk.dart';
import 'package:kasir_getx/app/modules/home/bindings/home_binding.dart';
import 'package:kasir_getx/app/modules/home/views/add_produk_view.dart';
import 'package:kasir_getx/app/modules/home/views/list_produk_view.dart';
import 'package:kasir_getx/app/modules/home/views/transaksi_produk_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => TransaksiProdukView(),
                binding: HomeBinding(),
              );
            },
            icon: Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {
              Get.to(
                () => AddProdukView(),
                binding: HomeBinding(),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => ListProdukView(),
                    binding: HomeBinding(),
                  );
                },
                child: Text("Tambah Produk")),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: controller.keranjang.length,
                itemBuilder: (_, i) {
                  ProdukTransaksiModel ptm = controller.keranjang[i];
                  return ListTile(
                    title: Text(ptm.namaProduk! + " ~ " + ptm.qty.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        controller.keranjang[i].qty =
                            controller.keranjang[i].qty! + 1;
                        controller.keranjang[i].hargaTotal =
                            controller.keranjang[i].hargaSatuan! *
                                controller.keranjang[i].qty!;
                        controller.totalHarga.value =
                            controller.totalHarga.value + ptm.hargaSatuan!;
                        controller.keranjang.refresh();
                      },
                      icon: Icon(Icons.add),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        if (controller.keranjang[i].qty == 1) {
                          controller.keranjang.removeWhere(
                              (element) => element.idProduk == ptm.idProduk);
                          controller.keranjang.refresh();
                        } else {
                          controller.keranjang[i].qty =
                              controller.keranjang[i].qty! - 1;
                          controller.keranjang[i].hargaTotal =
                              controller.keranjang[i].hargaSatuan! *
                                  controller.keranjang[i].qty!;

                          controller.keranjang.refresh();
                        }

                        controller.totalHarga.value =
                            controller.totalHarga.value - ptm.hargaSatuan!;
                      },
                      icon: Icon(Icons.remove),
                    ),
                    subtitle: Text(ptm.hargaTotal.toString()),
                  );
                },
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.keranjang.isNotEmpty,
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Total Harga"),
                      trailing: Text(controller.totalHarga.value.toString()),
                    ),
                    ListTile(
                      title: Text("Bayar"),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          onChanged: (v) {
                            controller.bayar.value = int.parse(v);
                          },
                          decoration: InputDecoration(hintText: "Bayar"),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("Total Kembalian"),
                      trailing: Text(
                          (controller.bayar.value - controller.totalHarga.value)
                              .toString()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.bayar.value == 0 ||
                            (controller.bayar.value -
                                    controller.totalHarga.value) <
                                0) {
                          Get.snackbar("Peringatan", "Cek kembali pembayaran");
                        } else {
                          List<ProdukTransaksiModel> tempPtm =
                              <ProdukTransaksiModel>[];
                          controller.keranjang.forEach((element) {
                            tempPtm.add(element);
                          });
                          TransaksiModel tm = TransaksiModel(
                            idTransaksi: controller.generateCode(),
                            bayar: controller.bayar.value,
                            kembalian: (controller.bayar.value -
                                controller.totalHarga.value),
                            totalHarga: controller.totalHarga.value,
                            daftarBarang: tempPtm,
                          );
                          controller.keranjang.forEach((element) {
                            controller
                                .produk[controller.produk.indexWhere(
                                    (produk) => produk.id == element.idProduk)]
                                .stokProduk = controller
                                    .produk[controller.produk.indexWhere(
                                        (produk) =>
                                            produk.id == element.idProduk)]
                                    .stokProduk! -
                                element.qty!;
                          });
                          controller.tambahTransaksi(tm);
                          controller.bayar.value = 0;
                          controller.totalHarga.value = 0;
                        }
                      },
                      child: Text("Bayar"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//SELESAI, TY