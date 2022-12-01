
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uas_2020130002/controller/transaksiController.dart';
import 'package:uas_2020130002/model/peminjaman.dart';

class EditTransaksi extends StatefulWidget {
  TransaksiController repository = TransaksiController();
  final Peminjaman peminjaman;
  EditTransaksi({Key? key, required this.peminjaman}) : super(key: key);

  @override
  State<EditTransaksi> createState() => _EditTransaksiState(peminjaman);
}

class _EditTransaksiState extends State<EditTransaksi> {
  late Peminjaman peminjaman;
  _EditTransaksiState(this.peminjaman);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton .extended(onPressed: () {  },
        icon : Icon(Icons.add),
        label: Text("Pinjam Buku"),
      ),
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Icon(Icons.accessibility_new_outlined),
            Text(peminjaman.idpeminjaman),
            Text(peminjaman.IdBuku),
            Text(peminjaman.npm),
            Text(peminjaman.waktupinjam!.toString()),
            Text(peminjaman.waktukembali!.toString()),
            Text(peminjaman.status),
          ],
        ),
      ),
    );
  }
}
