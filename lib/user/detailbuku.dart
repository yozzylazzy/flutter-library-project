import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/bukuController.dart';

import '../model/bukumodel.dart';

class DetailBuku extends StatelessWidget {

  BukuController repositorybuku = BukuController();
  final Buku buku;

  DetailBuku({Key? key, required this.buku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
