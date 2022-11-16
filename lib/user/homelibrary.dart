import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/bukulist.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/user/user.dart';
import 'package:filter_list/filter_list.dart';
import '../controller/bukuController.dart';
import '../model/bukumodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatelessWidget {
  Home(this.useruid);
  final String useruid;

  @override
  Widget build(BuildContext context) {
    return  HomeLibrary(useruid);
  }
}

class HomeLibrary extends StatefulWidget {
  // const HomeLibrary({Key? key}) : super(key: key);
  HomeLibrary(this.useruid);
  final String useruid;

  @override
  State<HomeLibrary> createState() => _HomeLibraryState();
}

class _HomeLibraryState extends State<HomeLibrary> {
  final List<String> bookList = [
    "Skripsi","Thesis","Buku Bacaan","Buku Ajar"
  ];
  List<String>? selectedBookList = [];
  late BukuController repository = new BukuController();

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
          child: Column(
            children: [
              SizedBox(height: 20,),
              GetAnggota(widget.useruid),
              SizedBox(height: 20,),
              Container(
                height: 180,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Expanded(child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 20,
                        shadowColor: Colors.deepPurple,
                        color: Color(0xffFAC32A),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20,),
                          Icon(Icons.collections_bookmark,
                          color: Colors.white, size: 40),
                          SizedBox(height: 20,),
                          Text("JUMLAH BUKU SAAT INI", style: TextStyle(
                            color: Colors.white, fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),),
                          SizedBox(height: 10,),
                          Text("670", style: TextStyle(
                            color: Colors.white, fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),),
                        ],
                      ),
                    )),),
                    SizedBox(width: 10,),
                  ],
                ),
              ), //Status Buku Pada Perpustakaan
              SizedBox(height: 20,),
              Row(
                children: [
                  Flexible(child: TextFormField(
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
                ],
              ),
              SizedBox(height: 20,),
              SizedBox(child: StreamBuilder(
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
                      crossAxisCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        // return GridTile(child: Text("hello"));
                        return BookCard(context, snapshot.data.docs[index]['JudulBuku'],
                            snapshot.data.docs[index]['JenisBuku'],
                            snapshot.data.docs[index]['halaman'].toString(),
                            snapshot.data.docs[index]['TahunTerbit'],
                            snapshot.data.docs[index]['Pengarang']);
                      },
                      itemCount: snapshot.data.docs.length,
                    );}
              ),),
            ],
          ),
        ),
    );
  }

  Widget BookCard(BuildContext context, String judul, String jenisbuku, String halaman, String tahun, String pengarang){
    return Container(
      height: 220,
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