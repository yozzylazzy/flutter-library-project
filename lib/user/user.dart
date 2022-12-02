// import 'package:flutter/cupertino.dart';
//
// class UserHome extends StatelessWidget {
//   const UserHome({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: Column(
//           children: [
//             Text("Ini Personal State User"),
//             Text("Ini Personal Status User"),
//             Text("Ini Wishlish"),
//             Text("Ini Pawdawd"),
//             Text("awdawd")
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _UserHomeState extends StatefulWidget {
//   const _UserHomeState({Key? key}) : super(key: key);
//
//   @override
//   State<_UserHomeState> createState() => _UserHomeStateState();
// }
//
// class _UserHomeStateState extends State<_UserHomeState> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/controller/transaksiController.dart';
import 'package:uas_2020130002/login.dart';


class HomeUser extends StatelessWidget {
  HomeUser(this.useruid);
  final String useruid;

  @override
  Widget build(BuildContext context) {
    return HomeUserContent(useruid);
  }
}

class HomeUserContent extends StatefulWidget {
  HomeUserContent(this.useruid);
  final String useruid;

  @override
  State<HomeUserContent> createState() => _HomeUserContentState(useruid);
}

class _HomeUserContentState extends State<HomeUserContent> {
  _HomeUserContentState(this.userid);
  final String userid;

  String gender = "";

  double circleRadius = 120.0;
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('anggota');

  String idmember='';
  int jumlahselesai = 0; int jumlahdipinjam =0;
  TransaksiController controllertransaksi = new TransaksiController();

  String _setImageUser(){
    String img = gender;
    String path = "";

    if(img == "Wanita") {
      path = "assets/images/girlhome.png";
    } else if(img == "Pria") {
      path = "assets/images/boyhome.png";
    } else {
      path = "assets/images/notfound.png";
    }
    return path;
  }

  @override
  void initState() {
    super.initState();
    getUserNPM(userid);
    // getjumlahSelesai();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Color(0xFF5B61D9),
                    borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(300,150)),
                  ),
                ),
                Positioned(
                    top: 30,
                    left: 10, right: 10,
                    child:
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Padding(padding:
                        EdgeInsets.only(left: 5, right: 5),child: Text("Member Card Perpustakaan", style:
                        TextStyle(
                            color: Colors.white, fontSize: 22,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Montserrat'
                        ),),),
                        SizedBox(height: 5,),
                        Text("Berikut Informasi Keanggotaan Perpustakaan Anda",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Sono',
                              color: Colors.white, fontSize: 12,
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          height: 200.0,
                        ),
                      ],
                    )
                ),
              ],
            )
        ),
        Center(
            child: Container(
              height: 500,
              width: double.infinity,
              child: Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Padding(
                          padding:
                          EdgeInsets.only(top: circleRadius / 2.0, ),  ///here we create space for the circle avatar to get ut of the box
                          child: Container(
                            child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 20,
                                shadowColor: Colors.deepPurple,
                                color: Colors.deepPurpleAccent,
                                child:
                                Column(
                                  children: [
                                    SizedBox(height: 70,),
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 2
                                      ),
                                    ),
                                    FutureBuilder(
                                      future:
                                      FirebaseFirestore.instance.collection('anggota').
                                      doc(widget.useruid).get(),
                                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                          gender = data['gender'];
                                          return Text(
                                            "${data['nama']}",
                                            style: TextStyle(
                                                color: Color(0xFFFAC32A),
                                                letterSpacing: 2,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold
                                            ),
                                          );
                                        }
                                        return Text(
                                          'Loading...',
                                          style: TextStyle(
                                              color: Color(0xFFFAC32A),
                                              letterSpacing: 2,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold
                                          ),
                                        );
                                      },),
                                    SizedBox(height: 30),
                                    Text(
                                      'Jenjang',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 2
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FutureBuilder(
                                      future:
                                      FirebaseFirestore.instance.collection('anggota').
                                      doc(widget.useruid).get(),
                                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                          return Text(
                                            "${data['jenjang']}",
                                            style: TextStyle(
                                                color: Color(0xFFFAC32A),
                                                letterSpacing: 2,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold
                                            ),
                                          );
                                        }
                                        return Text(
                                          "Loading...",
                                          style: TextStyle(
                                              color: Color(0xFFFAC32A),
                                              letterSpacing: 2,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold
                                          ),
                                        );
                                      },),
                                    SizedBox(height: 30),
                                    Padding(padding: EdgeInsets.only(left: 25, right: 25), child: Divider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    ),),
                                    SizedBox(height: 20,),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text('TOTAL PINJAMAN', style: TextStyle( fontSize: 16.0,  color: Colors.grey, fontWeight: FontWeight.w600),),
                                                  SizedBox(height: 10,),
                                                  Text(jumlahselesai.toString(), style: TextStyle( fontSize: 34.0, color: Colors.white),),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text('MASIH DIPINJAM', style: TextStyle( fontSize: 16.0,  color: Colors.grey, fontWeight: FontWeight.w600),),
                                                  SizedBox(height: 10,),
                                                  Text(jumlahdipinjam.toString(), style: TextStyle( fontSize: 34.0, color: Colors.white),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage(_setImageUser()),
                          radius: 60,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ]),
              ]),
            )
        ),
      ],
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
      controllertransaksi.getJumlahPinjamanSelesai(idmember).then((value) =>
          setState((){
            jumlahselesai = value;
          }));
      controllertransaksi.getJumlahDipinjam(idmember).then((value) => setState((){
        jumlahdipinjam = value;
      }));
    });
  }

  void loadUserData(String uid) async{
     GetAnggota(uid);
  }
}
