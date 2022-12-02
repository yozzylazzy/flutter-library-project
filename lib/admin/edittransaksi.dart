
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final GlobalKey<FormFieldState> _dropkey = GlobalKey<FormFieldState>();
  final TextEditingController inputId = TextEditingController();
  final TextEditingController IdBuku = TextEditingController();
  final TextEditingController npm = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController waktupinjam = TextEditingController();
  final TextEditingController waktukembali = TextEditingController();
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('transaksi');
  String selectedStatus = "";
  TransaksiController repository = TransaksiController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isiData();
  }

  void isiData(){
    inputId.text = peminjaman.idpeminjaman;
    IdBuku.text = peminjaman.IdBuku;
    npm.text = peminjaman.npm;
    selectedStatus = peminjaman.status;
    waktupinjam.text = peminjaman.waktupinjam.toString();
    waktukembali.text = peminjaman.waktukembali.toString();
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
                SizedBox(child: Text('INGIN MENGHAPUS ${peminjaman.idpeminjaman} ?',
                  style: TextStyle(
                      fontFamily: 'Sono', fontWeight: FontWeight.w800), textAlign: TextAlign.center,)),
                SizedBox(height: 10,),
                Divider(thickness: 4, color: Colors.deepPurple,
                )
              ],
            ),
              content: Text(
                  "Data Transaksi Ini Akan Terhapus Secara Permanen",
                  style: TextStyle(fontFamily: 'Montserrat', fontWeight:
                  FontWeight.w700)),
              actions: [
                TextButton(onPressed: () async {
                  repository.deleteTransaksi(peminjaman);
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
        label: Text("Hapus Transaksi"),
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
                      labelText: "ID Peminjaman"
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: IdBuku,
                  decoration: InputDecoration(
                    labelText: "ID Buku Dipinjam",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: npm,
                  decoration: InputDecoration(
                    labelText: "NPM Peminjam",
                  ),
                ),
                SizedBox(height: 30,),
                DropdownButtonFormField<String>(
                  key: _dropkey,
                  value: selectedStatus,
                  isExpanded: true,
                  //controller: ,
                  validator: (value) => value ==null ? 'Pilih Status Transaksi' : null,
                  items: <String>['dipesan', 'dipinjam', 'selesai'].map((String value)
                  {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Pilih Status Transaksi',
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
                  controller: waktupinjam,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Waktu Pinjam",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: waktukembali,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Waktu Kembali",
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
                            Navigator.pop(context);
                            peminjaman.status = selectedStatus;
                            repository.updateTransaksi(peminjaman);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(peminjaman.toJson().toString()))
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
