import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/addanggota.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/controller/bukuController.dart';

import '../model/anggotamodel.dart';

class AnggotaList extends StatelessWidget {
  const AnggotaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) {
          return AddAnggota();
        }),);
      },
      backgroundColor: Colors.red,
      child: const Icon(Icons.add),
    ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                        color: Colors.transparent,
                        image:  DecorationImage(image: AssetImage("assets/images/background.png"),
                            fit: BoxFit.fill)
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                                  child: Text("Latest Books", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                              ),
                              SizedBox(height: 15,),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Container(
                                  child: Card(
                                    child: Text("TESTING"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ),


              Padding(
                  padding: EdgeInsets.only(top: 70,left: 40
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Welcome To",style:
                        TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w500, fontSize: 20,
                            fontFamily: 'Sono'),textAlign: TextAlign.left,),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("M-Library",style:
                        TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w900, fontSize: 35,
                            fontFamily: 'Sono'),),
                      )
                    ],
                  )
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent)
            ),
          ),
          Expanded(
            child: FullAnggotaList()
            ,),
        ],
      )
        // child: Container(
        //   padding: EdgeInsets.all(20),
        //   child: Column(
        //     children: [
        //         Text("List Anggota"),
        //     ],
        //   ),
        // ),
    );
  }
}

class AnggotaCardList extends StatelessWidget {
  final Anggota anggota;
  final AnggotaController repository = new AnggotaController();
  AnggotaCardList({Key? key, required this.anggota}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        width: 300,
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(anggota.npm,style: TextStyle(fontWeight: FontWeight.bold),),
              Text(anggota.nama),
              Text(anggota.jenjang),
              Spacer(),
              IconButton(onPressed: () async {
                repository.deleteAnggota(anggota);
              },
                icon: Icon(Icons.restore_from_trash_rounded),
              ),
            ],
          ),
          onTap: (){
            // Navigator.push<Widget>(context, MaterialPageRoute(builder:
            //     (context)=> edit(product: product)));
          },
        ),
      ),
    );
  }
}

class FullAnggotaList extends StatefulWidget {
  const FullAnggotaList({Key? key}) : super(key: key);

  @override
  State<FullAnggotaList> createState() => _FullAnggotaListState();
}

class _FullAnggotaListState extends State<FullAnggotaList> {
  AnggotaController repository = AnggotaController();

  @override
  Widget build(BuildContext context) {
    return _buildAnggotaHome(context);
  }

  Widget _buildAnggotaHome(BuildContext context){
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot){
          if (!snapshot.hasData)
            return LinearProgressIndicator();
          return _buildList(context, snapshot.data?.docs ?? []);
        },
      ),
    );
  }
  Widget _buildList(BuildContext context, List<DocumentSnapshot>
  snapshot) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: snapshot.map((data) => _buildListItem(context,
          data)).toList(),
    );
  }
  Widget _buildListItem(BuildContext context, DocumentSnapshot
  snapshot) {
    var anggota = Anggota.fromSnapshot(snapshot);
    return AnggotaCardList(anggota: anggota);
  }

}



