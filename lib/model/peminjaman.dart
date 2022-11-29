import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Peminjaman{
  String idpeminjaman;
  String IdBuku;
  String npm;
  Timestamp? waktupinjam;
  Timestamp? waktukembali;
  String status;
  String? referenceId;

  Peminjaman(this.idpeminjaman, this.IdBuku, this.npm,this.waktupinjam,this.waktukembali, this.status);

  Peminjaman.fromJson(Map<String, dynamic> json):
        idpeminjaman = json['IDTransaksi'] as String,
        IdBuku = json['IdBuku'] as String,
        npm = json['npm'] as String,
        waktupinjam = json['waktupinjam'] as Timestamp,
        waktukembali = json['waktukembali'] as Timestamp,
        status = json['status'] as String;

  Map<String, dynamic> toJson()=>{
    'IDTransaksi': idpeminjaman,
    'IdBuku': IdBuku,
    'npm': npm,
    'waktupinjam': waktupinjam,
    'waktukembali': waktukembali,
    'status': status
  };

  factory Peminjaman.fromSnapshot(DocumentSnapshot snapshot){
    final newPeminjaman = Peminjaman.fromJson(snapshot.data() as Map<String, dynamic>);
    newPeminjaman.referenceId = snapshot.reference.id;
    return newPeminjaman;
  }

  factory Peminjaman.fromAsyncSnapshot(AsyncSnapshot snapshot){
    final newPeminjaman = Peminjaman.fromJson(snapshot.data() as Map<String, dynamic>);
    newPeminjaman.referenceId = snapshot.data.id;
    return newPeminjaman;
  }
}