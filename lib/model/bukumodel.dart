import 'package:cloud_firestore/cloud_firestore.dart';

class Buku{
  String id;
  String title;
  String penulis;
  String jenisbuku;
  int halaman;

  Buku(this.id,this.title,this.penulis,this.jenisbuku,this.halaman);

  Buku.fromJson(Map<String, dynamic> json):
      id = json['id'],
      title = json['title'],
      penulis = json['penulis'],
      jenisbuku = json['description'],
      halaman = json['halaman'];

  Map<String, dynamic> toJson()=>{
    'id':id,
    'title':title,
    'penulis':penulis,
    'jenisbuku':jenisbuku,
    'halaman':halaman
  };

  factory Buku.fromSnapshot(DocumentSnapshot snapshot){
    final newBuku = Buku.fromJson(snapshot.data() as Map<String, dynamic>);
    newBuku.id = snapshot.reference.id;
    return newBuku;
  }

}