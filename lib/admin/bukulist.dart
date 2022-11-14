import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/addbuku.dart';
import 'package:uas_2020130002/controller/bukuController.dart';
import 'package:uas_2020130002/model/bukumodel.dart';

class BukuList extends StatelessWidget {
  const BukuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) {
            return AddBuku();
          }),);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      body: FullBukuList(),
    );
  }
}


class BukuCardList extends StatelessWidget {
  final Buku buku;
  final BukuController repository = new BukuController();
  BukuCardList({Key? key, required this.buku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Card(
        child: InkWell(
          child: Row(
            children: [
              Flexible(child: Image.network(
                "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/qwqfyddzikcgc4ozwigp/revolution-5-road-running-shoesszF7CS.png",
                width: 100,
                height: 100,
              ),),
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Text(buku.title,style: TextStyle(fontWeight: FontWeight.bold),)),
                  Text(buku.jenisbuku),
                  Text(buku.tahunTerbit),
                ],
              ),),
              Spacer(),
              IconButton(onPressed: (){
                repository.deleteBuku(buku);
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

class FullBukuList extends StatefulWidget {
  const FullBukuList({Key? key}) : super(key: key);

  @override
  State<FullBukuList> createState() => _FullBukuListState();
}

class _FullBukuListState extends State<FullBukuList> {
  BukuController repository = BukuController();

  @override
  Widget build(BuildContext context) {
    return _buildBukuHome(context);
  }

  Widget _buildBukuHome(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
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
      height: 500,
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
    var buku = Buku.fromSnapshot(snapshot);
    return BukuCardList(buku: buku);
  }
}
