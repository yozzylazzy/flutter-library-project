
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:uas_2020130002/controller/transaksiController.dart';
import 'package:uas_2020130002/model/peminjaman.dart';
import 'package:uas_2020130002/user/detailbuku.dart';
import 'package:uas_2020130002/user/detailpeminjaman.dart';
import 'package:uas_2020130002/user/detailpinjamqr.dart';

import '../controller/bukuController.dart';
import '../model/bukumodel.dart';

class WishlistBook extends StatefulWidget {
  // const WishlistBook({Key? key}) : super(key: key);
  WishlistBook(this.useruid);
  final String useruid;

  @override
  State<WishlistBook> createState() => _WishlistBookState(useruid);
}

class _WishlistBookState extends State<WishlistBook> {
  late TransaksiController repository = new TransaksiController();
  final String useruid;
  _WishlistBookState(this.useruid);

  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('anggota');
  String idmember='';

  @override
  void initState(){
    super.initState();
    getUserNPM(useruid);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                        Padding(padding:EdgeInsets.only(left:5,right: 5)
                          ,child: Text("Buku Yang Sedang Dipinjam", textAlign: TextAlign.center, style:
                        TextStyle(
                            color: Colors.white, fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Montserrat'
                        ),),),
                        SizedBox(height: 5,),
                        Text("Cara Melakukan Peminjaman Buku di Perpustakaan",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Sono',
                              color: Colors.white, fontSize: 12,
                            )),
                        Padding(padding: EdgeInsets.all(2),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          height: 200.0,
                          child: Image.asset("assets/images/peminjaman.png"),
                        ),),
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
              "LIST BUKU DIPINJAM SEKARANG", style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
            ),
              textAlign: TextAlign.center,
            ),
            )
          ),
          SizedBox(height: 20,),
          bookCard(),
          SizedBox(height: 20,),
        ]),
    );
  }

  Future<void> getUserNPM(String userid) async {
    DocumentReference documentReference = collectionReference.doc(userid);
    String npm = '';
    await documentReference.get().then((snapshot) {
      npm = snapshot['npm'];
      setState(() {
        idmember = npm;
      });
    });
  }

  Widget bookCard(){
    return Padding(padding: EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(child: StreamBuilder(
          stream: repository.getPesananPengguna(idmember),
          builder: (BuildContext context, AsyncSnapshot  snapshot) {
            if (!snapshot.hasData) {
              return Center(child: LinearProgressIndicator(),);
            }
            if(snapshot.data?.size==0){
              return Center(
                  child: Stack(
                    children: [
                      Image.asset("assets/images/nodata.png"),
                      Center(child:  Column(
                        children: [
                          SizedBox(height: 330,),
                          Text("TIDAK ADA DATA", style:
                          TextStyle(
                              color: Colors.deepPurple, fontSize: 32,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Sono'
                          ),),
                        ],
                      )
                      ),
                    ],
                  )
              );
            }

            return StaggeredGridView.countBuilder(
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.fit(1),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 1,
              itemBuilder: (BuildContext context, int index) {
                Peminjaman peminjaman = new Peminjaman(snapshot.data.docs[index]['IDTransaksi'],
                    snapshot.data.docs[index]['IdBuku'], snapshot.data.docs[index]['npm'].toString(),
                    snapshot.data.docs[index]['waktupinjam'].toDate(),  snapshot.data.docs[index]['waktukembali'].toDate()
                    , snapshot.data.docs[index]['status']);
                return BookCard(context, peminjaman);
              },
              itemCount: snapshot.data.docs.length,
            );
          }
      ),),);
  }

  Widget BookCard(BuildContext context, Peminjaman peminjaman){
    final Buku buku;
    final BukuController repository = new BukuController();

    return Container(
      height: 300,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 20,
        shadowColor: Colors.deepPurple,
        color: Colors.deepPurpleAccent,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push<Widget>(
              context, MaterialPageRoute(builder: (context) {
              //return DetailBuku(buku: buku);
              return DetailPinjamAmbil(peminjaman: peminjaman,);
            }),);
          },
          child: Column(
            children: [
              Image.asset('assets/images/user.jpg'),
              SizedBox(height: 10,),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Text(
                      peminjaman.idpeminjaman,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(peminjaman.npm,style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  ),
                  SizedBox(width: 2,),
                  Text("-",style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),),
                  SizedBox(width: 2,),
                  Flexible(child: Text(peminjaman.status,style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  ),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


