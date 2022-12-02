import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/bukumodel.dart';

class BukuController{
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('buku');

  Stream<QuerySnapshot> getStream(){
    return collectionReference.snapshots();
  }

  Stream<QuerySnapshot> getStreamFiltered(String judul, List<String> jenis){
    return collectionReference.where("JudulBuku", isGreaterThanOrEqualTo: judul).where(
      "JudulBuku", isLessThan: judul + 'z').snapshots();
    // return collectionReference.where('JenisBuku', whereIn: jenis).snapshots();
  }

  void deleteBuku(Buku buku) async{
    await collectionReference.doc(buku.referenceId).delete();
  }

  Future<DocumentReference> addBuku(Buku buku){
    return collectionReference.add(buku.toJson());
  }

  void updateBuku(Buku buku) async {
    String? a = buku.referenceId;
    //disini reference Id kedetected null => harus didefinisiin dlu pake function
    await collectionReference.doc(a).update(buku.toJson()).then((value) => print("Updated!"))
        .catchError((error) => print("Failed to Update $error"));
  }

  Stream<QuerySnapshot> getSatuBuku(String id){
    return collectionReference.where("IdBuku", isEqualTo: id).snapshots();
  }

  Future<int> getJumlahBuku() async {
    AggregateQuerySnapshot query = await collectionReference.count().get();
    int hasil = query.count;
    return hasil;
  }
}

