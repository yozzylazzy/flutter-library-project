import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Peminjaman{
  String idpeminjaman;
  String IdBuku;
  String npm;
  DateTime? waktupinjam;
  DateTime? waktukembali;
  String status;
  String? referenceId;

  Peminjaman(this.idpeminjaman, this.IdBuku, this.npm,this.waktupinjam,this.waktukembali, this.status);

  // Peminjaman(this.idpeminjaman, this.IdBuku, this.npm,this.waktupinjam,this.waktukembali, this.status,
  //     this.referenceId);

  Peminjaman.fromJson(Map<String, dynamic> json):
        idpeminjaman = json['IDTransaksi'] as String,
        IdBuku = json['IdBuku'] as String,
        npm = json['npm'] as String,
        waktupinjam = (json['waktupinjam'] as Timestamp).toDate(),
        waktukembali = (json['waktukembali'] as Timestamp).toDate(),
        status = json['status'] as String;

  Map<String, dynamic> toJson()=>{
    'IDTransaksi': idpeminjaman,
    'IdBuku': IdBuku,
    'npm': npm,
    'waktupinjam': waktupinjam,
    'waktukembali': waktukembali,
    'status': status
  };

  Peminjaman.fromQRJson(Map<String, dynamic> json):
        idpeminjaman = json['IDTransaksi'] as String,
        IdBuku = json['IdBuku'] as String,
        npm = json['npm'] as String,
        waktupinjam = json['waktupinjam'] == null ? null : DateTime.parse((json['waktupinjam'])),
        waktukembali = json['waktukembali'] == null ? null : DateTime.parse((json['waktupinjam'])),
        status = json['status'] as String;

  Map<String, dynamic> toQRJson()=>{
    'IDTransaksi': idpeminjaman,
    'IdBuku': IdBuku,
    'npm': npm,
    'waktupinjam': waktupinjam == null ? null : waktupinjam!.toString(),
    'waktukembali': waktukembali == null ? null : waktukembali!.toString(),
    'status': status
  };

  //== null ? null : waktukembali!.toString()
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