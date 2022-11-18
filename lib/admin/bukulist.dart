import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/addbuku.dart';
import 'package:uas_2020130002/admin/editbuku.dart';
import 'package:uas_2020130002/controller/bukuController.dart';
import 'package:uas_2020130002/model/bukumodel.dart';

class BukuList extends StatefulWidget {
  const BukuList({Key? key}) : super(key: key);

  @override
  State<BukuList> createState() => _BukuListState();
}

class _BukuListState extends State<BukuList> {
  final List<String> bookList = [
    "Skripsi","Thesis","Buku Bacaan","Buku Ajar"
  ];
  List<String>? selectedBookList = [];
  late BukuController repository = new BukuController();

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
                        child: Text("BUKU",style:
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
              labelText: "Judul Buku",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.black
                ),
              ),
            ),
          ),),
          SizedBox(height: 20,),
          Expanded(child: FullBukuList(),),
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


class BukuCardList extends StatelessWidget {
  final Buku buku;
  final BukuController repository = new BukuController();
  BukuCardList({Key? key, required this.buku}) : super(key: key);

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
              Navigator.push<Widget>(context, MaterialPageRoute(builder:
                  (context)=> EditBuku(buku: buku)));
            },
          ),
        ),
      )
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
