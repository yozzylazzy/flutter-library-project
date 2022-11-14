import 'package:cloud_firestore/cloud_firestore.dart';

class Buku{
  String id;
  String title;
  String penulis;
  String jenisbuku;
  String tahunTerbit;
  int halaman;
  String? referenceId;

  Buku(this.id,this.title,
      this.penulis,this.jenisbuku,
      this.tahunTerbit,this.halaman);

  Buku.fromJson(Map<String, dynamic> json):
      id = json['IdBuku'],
      title = json['JudulBuku'],
      penulis = json['Pengarang'],
      jenisbuku = json['JenisBuku'],
      tahunTerbit = json['TahunTerbit'],
      halaman = json['halaman'];

  Map<String, dynamic> toJson()=>{
    'IdBuku': id,
    'JudulBuku': title,
    'Pengarang': penulis,
    'JenisBuku': jenisbuku,
    'TahunTerbit': tahunTerbit,
    'halaman': halaman
  };

  factory Buku.fromSnapshot(DocumentSnapshot snapshot){
    final newBuku = Buku.fromJson(snapshot.data() as Map<String, dynamic>);
    newBuku.referenceId = snapshot.reference.id;
    return newBuku;
  }

}