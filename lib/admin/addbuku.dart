import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/bukuController.dart';

import '../model/bukumodel.dart';

class AddBuku extends StatelessWidget {
  //const AddBuku({Key? key}) : super(key: key);
  final TextEditingController inputId = TextEditingController();
  final TextEditingController jenisBuku = TextEditingController();
  final TextEditingController judulBuku = TextEditingController();
  final TextEditingController pengarang = TextEditingController();
  final TextEditingController tahunTerbit = TextEditingController();
  final TextEditingController halaman = TextEditingController();

  BukuController repository = BukuController();
  late Buku buku;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Buku"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Form Menambah Buku"),
                SizedBox(height: 20,),
                TextFormField(
                  controller: inputId,
                  decoration: InputDecoration(
                    labelText: "ID Buku"
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: judulBuku,
                  decoration: InputDecoration(
                    labelText: "Judul Buku",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: jenisBuku,
                  decoration: InputDecoration(
                    labelText: "Jenis Buku",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: pengarang,
                  decoration: InputDecoration(
                    labelText: "Pengarang",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: tahunTerbit,
                  decoration: InputDecoration(
                    labelText: "Tahun Terbit",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: halaman,
                  decoration: InputDecoration(
                    labelText: "Halaman",
                  ),
                ),
                SizedBox(height: 40,),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(onPressed: (){
                        //Navigator.pop(context);
                        int halaman = 100;
                        Navigator.pop(context);
                        buku = new Buku(inputId.text, judulBuku.text,
                            pengarang.text, jenisBuku.text,
                            tahunTerbit.text, halaman);
                        repository.addBuku(buku);
                      }, child: Text("Tambah"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),))),
                      SizedBox(width: 30),
                      Flexible(child:
                      SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(onPressed: (){}, child:
                      Text("Reset"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          //fixedSize: Size(100, 50)
                        ),))
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
