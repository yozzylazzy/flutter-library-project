
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../controller/anggotaController.dart';
import '../model/anggotamodel.dart';

class EditAnggtota extends StatefulWidget {
  final Anggota anggota;
  const EditAnggtota({Key? key, required this.anggota}) : super(key: key);

  @override
  State<EditAnggtota> createState() => _EditAnggtotaState(anggota);
}

class _EditAnggtotaState extends State<EditAnggtota> {
  final GlobalKey<FormFieldState> _dropkey = GlobalKey<FormFieldState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordre = TextEditingController();
  final TextEditingController npm = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  final TextEditingController jenjang = TextEditingController();
  final TextEditingController tglmasuk = TextEditingController();
  String? selectedJenjang;
  String? _gender;

  AnggotaController repository = AnggotaController();

  final Anggota anggota;
  _EditAnggtotaState(this.anggota);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isiData();
  }

  void isiData(){
    npm.text = anggota.npm;
    nama.text = anggota.nama;
    _gender = anggota.gender;
    // _dropkey.currentState!.setState(() {
    //   selectedJenjang = anggota.jenjang;
    // });
    selectedJenjang = anggota.jenjang;
    alamat.text = anggota.alamat;
    tglmasuk.text = anggota.tglmasuk;
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
                SizedBox(child: Text('INGIN MENGHAPUS ${anggota.nama} ?',
                  style: TextStyle(
                      fontFamily: 'Sono', fontWeight: FontWeight.w800),)),
                SizedBox(height: 10,),
                Divider(thickness: 4, color: Colors.deepPurple,
                )
              ],
            ),
              content: Text(
                  "Data Anggota Telah Dihapus, SIalhkan kontak Ke Pihak IT Kami Untuk Pendaftaran Ulang",
                  style: TextStyle(fontFamily: 'Montserrat', fontWeight:
                  FontWeight.w700)),
              actions: [
                TextButton(onPressed: () async {
                  repository.deleteAnggota(anggota);
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
        label: Text("Hapus Anggota"),
        backgroundColor: Colors.deepPurple,
      ),
      appBar: AppBar(
        title: Text("Edit Anggota"),
        backgroundColor: Color(0xFF3F0CAD),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Form Mengedit Anggota"),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: npm,
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: "NPM Anggota"
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: nama,
                    decoration: InputDecoration(
                        labelText: "Nama Anggota"
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: alamat,
                    decoration: InputDecoration(
                        labelText: "Alamat Anggota"
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Flexible(
                        child: RadioListTile(
                          value: 'Pria',
                          groupValue: _gender,
                          onChanged: (String? value){
                            setState(() {
                              _gender = value;
                            });
                          },
                          title: const Text("Pria"),
                        ),
                      ),
                      Flexible(child: RadioListTile(
                        value: 'Wanita',
                        groupValue: _gender,
                        onChanged: (String? value){
                          setState(() {
                            _gender=value;
                          });
                        },
                        title: const Text("Wanita"),
                      )),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: DropdownButtonFormField<String>(
                        key: _dropkey,
                        value: selectedJenjang,
                        isExpanded: true,
                        //controller: ,
                        validator: (value) => value ==null ? 'Pilih Jenjang Pendidikan' : null,
                        items: <String>['D3', 'S1', 'S2', 'S3'].map((String value)
                        {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value){
                          setState(() {
                            selectedJenjang = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Pilih Jenjang',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),),
                    ],
                  ),
                  // TextFormField(
                  //   controller: jenjang,
                  //   decoration: InputDecoration(
                  //       labelText: "Jenjang Anggota"
                  //   ),
                  // ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: tglmasuk,
                    decoration: InputDecoration(
                        labelText: "Tanggal Masuk"
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
                            child: ElevatedButton(onPressed: () async {
                                anggota.nama = nama.text;
                                anggota.alamat = alamat.text;
                                anggota.gender = _gender!.toString();
                                anggota.jenjang = selectedJenjang.toString();
                                anggota.tglmasuk = tglmasuk.text;
                                repository.updateAnggota(anggota);
                                Navigator.pop(context);
                              //Navigator.pop(context);
                              // int halaman = 100;
                              // Navigator.pop(context);
                              // buku = new Buku(inputId.text, judulBuku.text,
                              //     pengarang.text, jenisBuku.text,
                              //     tahunTerbit.text, halaman);
                              // repository.addBuku(buku);
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
      ),
    );
  }
}
