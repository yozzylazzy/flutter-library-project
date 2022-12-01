import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/bukuController.dart';
import 'package:uas_2020130002/controller/transaksiController.dart';
import 'package:uas_2020130002/model/peminjaman.dart';

import '../model/bukumodel.dart';

class DetailPeminjaman extends StatefulWidget {
  final String bukuid, memberid;
  DetailPeminjaman({Key? key, required this.bukuid, required this.memberid}) : super(key: key);

  @override
  State<DetailPeminjaman> createState() => _DetailPeminjamanState();
}

class _DetailPeminjamanState extends State<DetailPeminjaman> {
  late BukuController repositorybuku = new BukuController();
  String lastid ='';
  late TransaksiController repositorypinjam = new TransaksiController();
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('transaksi');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLastID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F0CAD),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF3F0CAD),
        onPressed: (){
          showDialog(
              context: context, builder: (context){
            return AlertDialog(title: Column(
              children: [
                SizedBox(
                    child: Icon(Icons.warning, color: Colors.deepPurple,size: 45,)),
                SizedBox(height: 10,),
                SizedBox(child: Text('KONFIRMASI PEMINJAMAN',
                  style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
                SizedBox(height: 10,),
                Divider(thickness: 4,color: Colors.deepPurple,
                )
              ],
            ), content: Text("Konfirmasikan Bahwa Anda Akan Meminjam Buku Ini",
                style: TextStyle(fontFamily: 'Montserrat', fontWeight:
                FontWeight.w700)), actions: [
              TextButton(onPressed: () async {
                String x = lastid.substring(0,2);
                int y = int.parse(lastid.substring(2)) + 1;
                String newId = x+y.toString();

                bool bolehPinjam = false;

                if(await repositorypinjam.getValidasiBuku(widget.bukuid)){
                  if(await repositorypinjam.getJumlahDipinjam(widget.memberid)<3){
                    Peminjaman peminjaman = new Peminjaman(
                        newId, widget.bukuid, widget.memberid, DateTime.now(), DateTime.now(), "dipesan");
                    repositorypinjam.addTransaksi(peminjaman);
                    await showDialog(context: context, builder: (_) => dialogKonfirmasi(context));
                  } else {
                    await showDialog(context: context, builder: (_) => dialogKelebihanPinjam(context));
                  }
                } else {
                  await showDialog(context: context, builder: (_) => dialogGagalPinjam(context));
                }
                Navigator.of(context).pop();

              }, child: Text("PINJAM")),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("BATAL")
              ),
            ],
            );
          }
          );
        },
        icon : Icon(Icons.bookmark_add),
        label: Text("PINJAM BUKU"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                backgroundDetail(),
              ],
            ),
            SizedBox(height: 120,),
            Container(
                child:
              StreamBuilder(
                  stream: repositorybuku.getSatuBuku(widget.bukuid),
                  builder: (BuildContext context, AsyncSnapshot  snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }
                    return detailBuku(context,snapshot);
                  })
              // child: detailBuku(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setLastID() async {
    Query<Object?> documentReference = await collectionReference.orderBy("IDTransaksi", descending: true).limit(1);
    String id = '';
    await documentReference.get().then((snapshot) {
      id = snapshot.docs[0]['IDTransaksi'];
      setState(() {
        lastid = id;
      });
    });
  }//Work

  Widget dialogKelebihanPinjam(BuildContext context){
    return AlertDialog(title: Column(
      children: [
        SizedBox(
            child: Icon(Icons.dangerous_outlined, color: Colors.red,size: 45,)),
        SizedBox(height: 10,),
        SizedBox(child: Text('GAGAL DIPESAN',
          style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
        SizedBox(height: 10,),
        Divider(thickness: 4,color: Colors.deepPurple,
        )
      ],
    ), content: Text("Anda telah memenuhi batas maksimal meminjam buku yaitu 3, silahkan "
        "kembalikan buku yang sedang dipinjam",
        style: TextStyle(fontFamily: 'Montserrat', fontWeight:
        FontWeight.w700)), actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: Text("OK")),
    ],
    );
  }

  Widget dialogGagalPinjam(BuildContext context){
    return AlertDialog(title: Column(
      children: [
        SizedBox(
            child: Icon(Icons.dangerous_outlined, color: Colors.red,size: 45,)),
        SizedBox(height: 10,),
        SizedBox(child: Text('GAGAL DIPESAN',
          style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
        SizedBox(height: 10,),
        Divider(thickness: 4,color: Colors.deepPurple,
        )
      ],
    ), content: Text("Buku masih dipinjam oleh orang lain, silahkan tunggu hingga ia selesai meminjam",
        style: TextStyle(fontFamily: 'Montserrat', fontWeight:
        FontWeight.w700)), actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: Text("OK")),
    ],
    );
  }

  Widget dialogKonfirmasi(BuildContext context){
    return AlertDialog(title: Column(
      children: [
        SizedBox(
            child: Icon(Icons.info, color: Colors.lightBlue,size: 45,)),
        SizedBox(height: 10,),
        SizedBox(child: Text('TELAH DIPESAN',
          style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
        SizedBox(height: 10,),
        Divider(thickness: 4,color: Colors.deepPurple,
        )
      ],
    ), content: Text("Anda telah memesan buku ini, silahkan pinjam dalam waktu dibawah 24 jam, jika tidak pesanan akan otomatis diselesaikan",
        style: TextStyle(fontFamily: 'Montserrat', fontWeight:
        FontWeight.w700)), actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: Text("OK")),
    ],
    );
  }

  Widget detailBuku(BuildContext context, AsyncSnapshot snapshot){
    return Column(
      children: [
        Align(
          child: Text(
            snapshot.data.docs[0]['JudulBuku'], style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 35,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Deskripsi Buku", style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
              fontSize: 15,
            ),
              textAlign: TextAlign.left,
            ),
          ),),
        SizedBox(height: 2,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.bukuid, style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
            ),
              textAlign: TextAlign.left,
            ),
          ),),
        SizedBox(height: 15,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Divider(height: 2,color: Colors.grey,),),
        SizedBox(height: 15,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "ID Buku", style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
              fontSize: 15,
            ),
              textAlign: TextAlign.left,
            ),
          ),),
        SizedBox(height: 2,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.bukuid, style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
            ),
              textAlign: TextAlign.left,
            ),
          ),),
        SizedBox(height: 15,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Pengarang Buku", style: TextStyle(
              fontFamily: 'Montserrat',fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
              textAlign: TextAlign.left,
            ),
          ),),
        SizedBox(height: 2,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              snapshot.data.docs[0]['Pengarang'], style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
            ),
              textAlign: TextAlign.left,
            ),
          ),),
        SizedBox(height: 15,),
        Padding(padding: EdgeInsets.only(left: 30, right: 30),
          child: Divider(height: 2,color: Colors.grey,),),
        SizedBox(height: 15,),
        Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tahun Terbit Buku", style: TextStyle(
                        fontFamily: 'Montserrat',fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),),
                  SizedBox(height: 2,),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        snapshot.data.docs[0]['TahunTerbit'], style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Halaman Buku", style: TextStyle(
                        fontFamily: 'Montserrat',fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),),
                  SizedBox(height: 2,),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        snapshot.data.docs[0]['halaman'].toString(), style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),),
                  SizedBox(height: 15,),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget backgroundDetail(){
    return Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                Flexible(child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF5B61D9),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(200,150)),
                  ),
                ),),
              ],
            ),
            Positioned(
                top: 30,
                left: 10, right: 10,
                child:
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      height: 350.0,
                      child: Center(
                        child: Image.asset("assets/images/bukulist.png"),
                      ),
                    ),
                  ],
                )
            ),
          ],
        )
    );
  }
}
