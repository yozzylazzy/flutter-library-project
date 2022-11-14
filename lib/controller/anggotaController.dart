import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

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
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Selamat Datang, ${data['nama']}");
        }
        return Text("loading");
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