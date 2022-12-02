import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/bukuController.dart';

import '../model/bukumodel.dart';

class EditBuku extends StatefulWidget {
  final Buku buku;
  EditBuku({Key? key, required this.buku}) : super(key: key);

  @override
  State<EditBuku> createState() => _EditBukuState(buku);
}

class _EditBukuState extends State<EditBuku> {
  final GlobalKey<FormFieldState> _dropkey = GlobalKey<FormFieldState>();
  final TextEditingController inputId = TextEditingController();
  final TextEditingController jenisBuku = TextEditingController();
  final TextEditingController judulBuku = TextEditingController();
  final TextEditingController pengarang = TextEditingController();
  final TextEditingController tahunTerbit = TextEditingController();
  final TextEditingController halaman = TextEditingController();
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('buku');
  String selectedJenis = "";
  BukuController repository = BukuController();
  final Buku buku;
  _EditBukuState(this.buku);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isiData();
  }

  void isiData(){
    inputId.text = buku.id;
    jenisBuku.text = buku.jenisbuku;
    judulBuku.text = buku.title;
    selectedJenis = buku.jenisbuku;
    pengarang.text = buku.penulis;
    tahunTerbit.text = buku.tahunTerbit;
    halaman.text = buku.halaman.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(context: context, builder: (context)
          {
            return AlertDialog(title: Column(
              children: [
                SizedBox(
                    child: Icon(Icons.dangerous, color: Colors.red, size: 45,)),
                SizedBox(height: 10,),
                SizedBox(child: Text('INGIN MENGHAPUS ${buku.title} ?',
                  style: TextStyle(
                      fontFamily: 'Sono', fontWeight: FontWeight.w800), textAlign: TextAlign.center,)),
                SizedBox(height: 10,),
                Divider(thickness: 4, color: Colors.deepPurple,
                )
              ],
            ),
              content: Text(
                  "Data Buku Ini Akan Terhapus Secara Permanen dan Tidak Dapat Dikembalikan Kecuali Dimasukkan"
                      " Kembali Secara Manual",
                  style: TextStyle(fontFamily: 'Montserrat', fontWeight:
                  FontWeight.w700)),
              actions: [
                TextButton(onPressed: () async {
                  repository.deleteBuku(buku);
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                }, child: Text("HAPUS")),
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("BATAL")
                ),
              ],
            );
          });
        },
        icon : Icon(Icons.delete_forever_sharp),
        label: Text("Hapus Buku"),
        backgroundColor: Colors.deepPurple,
      ),
      appBar: AppBar(
        title: Text("Edit Buku"),
        backgroundColor: Color(0xFF3F0CAD),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Form Mengedit Buku"),
                SizedBox(height: 20,),
                TextFormField(
                  controller: inputId,
                  enabled: false,
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
                SizedBox(height: 30,),
                DropdownButtonFormField<String>(
                  key: _dropkey,
                  value: selectedJenis,
                  isExpanded: true,
                  //controller: ,
                  validator: (value) => value ==null ? 'Pilih Jenis Buku' : null,
                  items: <String>['Skripsi', 'Thesis', 'Buku Ajar', 'Buku Bacaan'].map((String value)
                  {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedJenis = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Pilih Jenis Buku',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                              int x = int.parse(halaman.text);
                              Navigator.pop(context);
                              buku.id = inputId.text;
                              buku.title = judulBuku.text;
                              buku.penulis = pengarang.text;
                              buku.jenisbuku = selectedJenis;
                              buku.tahunTerbit = tahunTerbit.text;
                              buku.halaman = x;
                              repository.updateBuku(buku);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(buku.toJson().toString()))
                              );
                          }, child: Text("UBAH"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),))),
                      SizedBox(width: 30),
                      Flexible(child:
                      SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(onPressed: (){}, child:
                          Text("RESET"),
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
