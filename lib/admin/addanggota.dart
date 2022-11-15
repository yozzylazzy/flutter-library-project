

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/model/anggotamodel.dart';

class AddAnggota extends StatefulWidget {
  @override
  State<AddAnggota> createState() => _AddAnggotaState();
}

class _AddAnggotaState extends State<AddAnggota> {
  //const AddAnggota({Key? key}) : super(key: key);
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

  late Anggota anggota;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Anggota"),
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
                  Text("Form Menambah Anggota"),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: npm,
                    decoration: InputDecoration(
                        labelText: "NPM Anggota"
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        labelText: "Password"
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordre,
                    decoration: InputDecoration(
                        labelText: "Re-enter Password"
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
                          String email = npm.text + "@co.id";
                          String passworduser;
                          if(password.text == passwordre.text){
                            passworduser = password.text;
                            UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passworduser);
                            User? user = result.user;
                            anggota = new Anggota(npm.text, nama.text, alamat.text, selectedJenjang.toString(), tglmasuk.text,_gender.toString());
                            Map<String, dynamic> anggotaData = anggota.toJson();
                            await FirebaseFirestore.instance.collection('anggota')
                                .doc(user?.uid).set(anggotaData);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const
                            SnackBar(content: Text("Password Tidak Sama")));
                          }
                          //Navigator.pop(context);
                          // int halaman = 100;
                          // Navigator.pop(context);
                          // buku = new Buku(inputId.text, judulBuku.text,
                          //     pengarang.text, jenisBuku.text,
                          //     tahunTerbit.text, halaman);
                          // repository.addBuku(buku);
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
      ),
    );
  }
}
