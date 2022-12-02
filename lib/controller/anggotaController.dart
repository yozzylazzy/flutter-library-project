import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/login.dart';
import 'dart:developer';
import 'dart:core';

import '../model/anggotamodel.dart';

//Dapatkan 1 info anggota
class GetAnggota extends StatelessWidget {
  final String documentId;

  GetAnggota(this.documentId);

  @override
  Widget build(BuildContext context) {
    //CollectionReference anggota = FirebaseFirestore.instance.collection("anggota").snapshots();
    CollectionReference anggota = FirebaseFirestore.instance.collection('anggota');

    return FutureBuilder<DocumentSnapshot>(
      future: anggota.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return Text("Something went wrong", style: TextStyle(
            color: Colors.white, fontSize: 25,
            fontWeight: FontWeight.w500,
          ),);
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist", style: TextStyle(
            color: Colors.white, fontSize: 25,
            fontWeight: FontWeight.w500,
          ),);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(padding: EdgeInsets.only(left: 20,right: 20),
          child: Text("Selamat Datang, ${data['nama']}", style:
          TextStyle(
              color: Colors.white, fontSize: 25,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat'
          ),));
        }
        return Text("Loading...", style:
        TextStyle(
            color: Colors.grey, fontSize: 25,
            fontWeight: FontWeight.w800,
            fontFamily: 'Montserrat'
        ),);
      },
    );
  }
}

void onSearch() async {
  final String _collection = 'anggota';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  getData() async {
    return await _fireStore.collection(_collection).get();
  }

  //Ini sudah jalan dan berhasil untuk load user
  getData().then((val){
    if(val.docs.length > 0){
      print(val.docs[0].get("npm"));
      print(val.docs[0].get("nama"));
      print(val.docs[0].get("email"));
      print(val.docs[0].get("password"));
    }
    else{
      print("Not Found");
    }
  });
}

class AnggotaController{
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('anggota');

  Stream<QuerySnapshot> getStream(){
    return collectionReference.snapshots();
  }

  Stream<QuerySnapshot> getStreamFiltered(String npm){
    return collectionReference.where("npm", isGreaterThanOrEqualTo: npm).where(
        "npm", isLessThan: npm + 'z').snapshots();
  }

  void deleteAnggota(Anggota anggota) async{
    await collectionReference.doc(anggota.referenceId).delete();
  }
  Future<DocumentReference> addAnggota(Anggota anggota){
    return collectionReference.add(anggota.toJson());
  }
  void updateAnggota(Anggota anggota) async {
    await collectionReference.doc(anggota.referenceId).update(anggota.toJson());
  }


}