import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/login.dart';

import '../controller/transaksiController.dart';
import '../controller/transaksiController.dart';
import '../model/peminjaman.dart';

class HistoryPage extends StatelessWidget {
  // const HistoryPage({Key? key}) : super(key: key);
  HistoryPage(this.useruid);
  final String useruid;
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('anggota');

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(90,0)),
                          ),
                        ),),
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(90,50)),
                          ),
                        ),),
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(90,50)),
                          ),
                        ),),
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(90,0)),
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
                            Text("Buku Yang Selesai Dipinjam",textAlign: TextAlign.center, style:
                            TextStyle(
                                color: Colors.white, fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat',
                            ),),
                            SizedBox(height: 5,),
                            Text("Buku Yang Selesai Dipinjam Baru-Baru Ini",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Sono',
                                  color: Colors.white, fontSize: 12,
                                )),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20.0),
                              height: 200.0,
                              child: Text("Hi"),
                            ),
                          ]),),
                  ]),
            ),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(left: 20, right: 20), child: Divider(
              color: Colors.grey,
              thickness: 2,
            ),),
            SizedBox(height: 20,),
            Align(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "LIST LENGKAP BUKU SELESAI DIPINJAM", style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                  ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
            SizedBox(height: 20,),
            Expanded(
                child: HistoryList(id:
                getUserNPM(useruid).toString()
                )
            ),
            // Text(getUserNPM(useruid)),
          ]);
  }

  String getUserNPM(String userid)  {
    DocumentReference documentReference = collectionReference.doc(userid);
    String npm = ' ';
    documentReference.get().then((snapshot) {
      npm = snapshot['npm'];
      print(npm);
    });
    //debugPrint(npm);
    return npm;
  }
}

class HistoryCardList extends StatelessWidget {
  final Peminjaman peminjaman;
  final TransaksiController repository = new TransaksiController();
  HistoryCardList({Key? key, required this.peminjaman}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 100,
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Card(
            child: InkWell(
              child: Row(
                children: [
                  Flexible(child: Image.asset("assets/images/bukulist.png"
                    ,
                    width: 100,
                    height: 100,
                  ),),
                  Flexible(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Text(peminjaman.idpeminjaman,style: TextStyle(fontWeight: FontWeight.bold),)),
                      Text(peminjaman.IdBuku),
                      Text(peminjaman.npm),
                      Text(peminjaman.status),
                    ],
                  ),),
                  Spacer(),
                  IconButton(onPressed: (){

                  },
                    icon: Icon(Icons.qr_code_scanner),
                  ),
                ],
              ),
              onTap: (){
                // Navigator.push<Widget>(context, MaterialPageRoute(builder:
                //     (context)=> EditTransaksi(peminjaman: peminjaman)));
              },
            ),
          ),
        )
    );
  }
}

class HistoryList extends StatefulWidget {
  final String id;
  HistoryList({Key? key, required this.id}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState(id);
}

class _HistoryListState extends State<HistoryList> {
  final String id;
  _HistoryListState(this.id);
  TransaksiController repository = TransaksiController();

  @override
  Widget build(BuildContext context) {
    return _buildHistoryList(context);
  }

  Widget _buildHistoryList(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getTransaksiPengguna(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LinearProgressIndicator();
          return _buildList(context, snapshot.data?.docs ?? []);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>
  snapshot) {
    return SizedBox(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: snapshot.map((data) =>
            _buildListItem(context,
                data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot
  snapshot) {
    var peminjaman = Peminjaman.fromSnapshot(snapshot);
    return HistoryCardList(peminjaman: peminjaman);
  }
}
