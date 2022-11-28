import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/bukuController.dart';

import '../model/bukumodel.dart';

class EditBuku extends StatelessWidget {
  BukuController repositorybuku = BukuController();
  final Buku buku;
  EditBuku({Key? key, required this.buku}) : super(key: key);

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
            Text(buku.title),
            Text(buku.penulis),
            Text(buku.jenisbuku),
            Text(buku.tahunTerbit),
          ],
        ),
      ),
    );
  }
}
