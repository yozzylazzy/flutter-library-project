import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/addanggota.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/controller/bukuController.dart';

import '../model/anggotamodel.dart';

class AnggotaList extends StatefulWidget {
  const AnggotaList({Key? key}) : super(key: key);

  @override
  State<AnggotaList> createState() => _AnggotaListState();
}

class _AnggotaListState extends State<AnggotaList> {
  final List<String> angggotaList = [
    "2020","2021","2022","2023"
  ];
  List<String>? selectedAnggotaList = [];
  late AnggotaController repository = new AnggotaController();

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
      backgroundColor: Colors.deepPurple,
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
                    child:  Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Container(
                          width: 400,
                        )
                    ),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 70,left: 40
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Laman Administrator",style:
                        TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w500, fontSize: 20,
                            fontFamily: 'Sono'),textAlign: TextAlign.left,),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("ANGGOTA",style:
                        TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w900, fontSize: 35,
                            fontFamily: 'Sono'),),
                      )

                    ],
                  )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child:TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(icon : Icon(Icons.list), onPressed: _openFilterDialog,),
                labelText: "Nama/NPM Anggota",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.black
                  ),
                ),
              ),
            ),),
          SizedBox(height: 20,),
          Expanded(
            child: FullAnggotaList()
            ,),
        ],
      )
    );
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<String>(
      this.context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(this.context),
      headlineText: 'Pilih Tahun Gabung Anggota',
      height: 500,
      listData: angggotaList,
      selectedListData: selectedAnggotaList,
      choiceChipLabel: (item) => item!,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (item, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return item.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedAnggotaList = List.from(list!);
        });
        Navigator.pop(this.context);
      },

      /// uncomment below code to create custom choice chip
      /* choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(
            color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
          )),
          child: Text(
            item.name,
            style: TextStyle(
                color: isSelected ? Colors.blue[300] : Colors.grey[500]),
          ),
        );
      }, */
    );
  }
}

class AnggotaCardList extends StatelessWidget {
  final Anggota anggota;
  final AnggotaController repository = new AnggotaController();
  AnggotaCardList({Key? key, required this.anggota}) : super(key: key);

  String _setImageUser(){
    String img = "${anggota.gender}";
    String path = "";

    if(img == "Wanita") {
      path = "assets/images/wanita.png";
    } else if(img == "Pria") {
      path = "assets/images/pria.png";
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left:10, right: 10),
    child: Card(
      child: SizedBox(
        height: 100,
        width: 300,
        child: InkWell(
          child: Row(
            children: [
              Flexible(child:
              Padding(
                padding: EdgeInsets.all(5),
                child: Image.asset(_setImageUser()
                  ,
                  width: 100,
                  height: 100,
                ),
              )),
              Column(
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
            ],
          ),
          onTap: (){
            // Navigator.push<Widget>(context, MaterialPageRoute(builder:
            //     (context)=> edit(product: product)));
          },
        ),
      ),
    ),);
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



