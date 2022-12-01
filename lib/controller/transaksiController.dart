import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uas_2020130002/model/peminjaman.dart';

import '../model/bukumodel.dart';

class TransaksiController{
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('transaksi');

  Stream<QuerySnapshot> getStream(){
    return collectionReference.snapshots();
  }
  void deleteTransaksi(Peminjaman peminjaman) async{
    await collectionReference.doc(peminjaman.referenceId).delete();
  }
  Future<DocumentReference> addTransaksi(Peminjaman peminjaman){
    return collectionReference.add(peminjaman.toJson());
  }
  void updateTransaksi(Peminjaman peminjaman) async {
    await collectionReference.doc(peminjaman.referenceId).update(peminjaman.toJson());
  }

  Stream<QuerySnapshot> getTransaksiPengguna(String id){
    return collectionReference.where("npm", isEqualTo: id).where("status", isEqualTo: "selesai").snapshots();
  }

  Stream<QuerySnapshot> getPesananPengguna(String id){
    return collectionReference.where("npm", isEqualTo: id).where("status", whereIn: ["dipesan","dipinjam"]).snapshots();
  }

  Future<int> getJumlahPinjamanSelesai(String id) async {
    AggregateQuerySnapshot query = await collectionReference.where("npm", isEqualTo: id).where("status", isEqualTo: "selesai").count().get();
    int hasil = query.count;
    return hasil;
  }

  Future<int> getJumlahDipinjam(String id) async {
    AggregateQuerySnapshot query = await collectionReference.where("npm", isEqualTo: id).where("status", whereIn: ["dipesan","dipinjam"]).count().get();
    int hasil = query.count;
    return hasil;
  }

  Future<bool> getValidasiBuku(String bukuid) async{
    AggregateQuerySnapshot query = await collectionReference.where("status", whereIn: ["dipesan","dipinjam"]).
        where("IdBuku", isEqualTo: bukuid).count().get();
    int hasil = query.count;
    if (hasil>0){
      return false;
    } else if (hasil<1){
      return true;
    } else {
      return false;
    }
  }
}

