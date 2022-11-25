import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/edittransaksi.dart';
import 'package:uas_2020130002/admin/scantransaksi.dart';
import 'package:uas_2020130002/controller/transaksiController.dart';
import 'package:uas_2020130002/model/peminjaman.dart';

class TransaksiBukuList extends StatefulWidget {
  const TransaksiBukuList({Key? key}) : super(key: key);

  @override
  State<TransaksiBukuList> createState() => _TransaksiBukuListState();
}

class _TransaksiBukuListState extends State<TransaksiBukuList> {
  final List<String> bookList = [
    "Skripsi","Thesis","Buku Bacaan","Buku Ajar"
  ];
  List<String>? selectedBookList = [];
  late TransaksiController repository = new TransaksiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: (){
      Navigator.push(
        context, MaterialPageRoute(builder: (context) {
        return ScanTransaksi();
      }),);
        },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.qr_code_scanner),
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
                        child: Text("TRANSAKSI",style:
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
                labelText: "LIST TRANSAKSI",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.black
                  ),
                ),
              ),
            ),),
          SizedBox(height: 20,),
          Expanded(child: FullTransaksiList(),),
        ],
      )
    );
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<String>(
      this.context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(this.context),
      headlineText: 'Pilih Jenis Buku',
      height: 500,
      listData: bookList,
      selectedListData: selectedBookList,
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
          selectedBookList = List.from(list!);
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


class TransaksiCardList extends StatelessWidget {
  final Peminjaman peminjaman;
  final TransaksiController repository = new TransaksiController();
  TransaksiCardList({Key? key, required this.peminjaman}) : super(key: key);

  String _setImageStatus(){
    String img = "${peminjaman.status}";
    String path = "";
    if(img == "dipesan") {
      path = "assets/images/dipesan.png";
    } else if(img == "dipinjam") {
      path = "assets/images/dipinjam.png";
    } else if (img == "selesai"){
      path = "assets/images/selesai.png";
    }
    return path;
  }

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
                  Flexible(child: Image.asset(_setImageStatus(),
                    width: 100,
                    height: 100,
                  ),),
                  SizedBox(width: 20,),
                  Flexible(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Flexible(child: Text(peminjaman.idpeminjaman,style: TextStyle(fontWeight: FontWeight.bold),)),
                      Text(peminjaman.IdBuku),
                      Text(peminjaman.npm),
                      Text(peminjaman.status),
                    ],
                  ),),
                  Spacer(),
                  IconButton(onPressed: (){

                  },
                    icon: Icon(Icons.qr_code_2),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push<Widget>(context, MaterialPageRoute(builder:
                    (context)=> EditTransaksi(peminjaman: peminjaman)));
              },
            ),
          ),
        )
    );
  }
}

class FullTransaksiList extends StatefulWidget {
  const FullTransaksiList({Key? key}) : super(key: key);

  @override
  State<FullTransaksiList> createState() => _FullTransaksiListState();
}

class _FullTransaksiListState extends State<FullTransaksiList> {
  TransaksiController repository = TransaksiController();

  @override
  Widget build(BuildContext context) {
    return _buildTransaksiHome(context);
  }

  Widget _buildTransaksiHome(BuildContext context) {
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
    return TransaksiCardList(peminjaman: peminjaman);
  }
}
