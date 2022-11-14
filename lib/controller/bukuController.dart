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
  void deleteBuku(Buku buku) async{
    await collectionReference.doc(buku.id).delete();
  }
  Future<DocumentReference> addBuku(Buku buku){
    return collectionReference.add(buku.toJson());
  }
  void updateBuku(Buku buku) async {
    await collectionReference.doc(buku.id).update(buku.toJson());
  }
}

