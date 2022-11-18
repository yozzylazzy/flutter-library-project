
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:uas_2020130002/user/detailbuku.dart';
import 'package:uas_2020130002/user/detailpeminjaman.dart';
import 'package:uas_2020130002/user/detailpinjamqr.dart';

import '../controller/bukuController.dart';
import '../model/bukumodel.dart';

class WishlistBook extends StatelessWidget {
  // const WishlistBook({Key? key}) : super(key: key);
  WishlistBook(this.useruid);
  final String useruid;
  late BukuController repository = new BukuController();

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
                        Text("Buku Yang Sedang Dipinjam", textAlign: TextAlign.center, style:
                        TextStyle(
                            color: Colors.white, fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Montserrat'
                        ),),
                        SizedBox(height: 5,),
                        Text("Buku Yang Sedang Dipinjam Saat Ini",
                            textAlign: TextAlign.left,
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
        ]),
    );
  }
  Widget bookCard(){
    return Padding(padding: EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(child: StreamBuilder(
          stream: repository.getStream(),
          builder: (BuildContext context, AsyncSnapshot  snapshot) {
            if (!snapshot.hasData) {
              return Center(child: const Text('Mohon Tunggu Sebentar...'));
            }
            return StaggeredGridView.countBuilder(
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.fit(1),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return BookCard(context, snapshot.data.docs[index]['JudulBuku'],
                    snapshot.data.docs[index]['JenisBuku'],
                    snapshot.data.docs[index]['halaman'].toString(),
                    snapshot.data.docs[index]['TahunTerbit'],
                    snapshot.data.docs[index]['Pengarang']);
              },
              itemCount: snapshot.data.docs.length,
            );}
      ),),);
  }

  Widget BookCard(BuildContext context, String judul, String jenisbuku, String halaman, String tahun, String pengarang){
    final Buku buku;
    final BukuController repository = new BukuController();
    // BookCard({Key? key, required this.buku}) : super(key: key);

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
              return DetailPinjamAmbil();
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
                      judul,
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
                  Text(jenisbuku,style: TextStyle(
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
                  Flexible(child: Text(tahun,style: TextStyle(
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


