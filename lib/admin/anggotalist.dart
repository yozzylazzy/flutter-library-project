import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: FullAnggotaList(),
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
              IconButton(onPressed: (){
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



