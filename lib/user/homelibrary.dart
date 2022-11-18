import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/bukulist.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/user/detailbuku.dart';
import 'package:uas_2020130002/user/detailpeminjaman.dart';
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
        child: Column(
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
                    borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(300,150)),
                  ),
                  ),
                    Positioned(
                      top: 30,
                        left: 10, right: 10,
                      child:
                      Column(
                        children: [
                          GetAnggota(widget.useruid),
                          SizedBox(height: 10,),
                          Text("Berikut Informasi Perpustakaan : ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Sono',
                                color: Colors.white, fontSize: 12,
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            height: 200.0,
                            child: bookHorizontalInfo(),
                          ),
                        ],
                      )
                    ),
                  ],
                )
              ),
              SizedBox(height: 20,),
              Text("CARI/FILTER DATA BUKU", style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontFamily: 'Montserrat',
              )),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
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
                ),),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 20, right: 20), child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),),
              SizedBox(height: 20,),
              Align(
                child: Text(
                  "LIST SEMUA BUKU", style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 20, right: 20),
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
                      crossAxisCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return BookCard(context, snapshot.data.docs[index]['JudulBuku'],
                            snapshot.data.docs[index]['JenisBuku'],
                            snapshot.data.docs[index]['halaman'].toString(),
                            snapshot.data.docs[index]['TahunTerbit'],
                            snapshot.data.docs[index]['Pengarang']);
                      },
                      itemCount: snapshot.data.docs.length,
                    );}
              ),),)
            ],
          ),
    );
  }

  Widget BookCard(BuildContext context, String judul, String jenisbuku, String halaman, String tahun, String pengarang){
    final Buku buku;
    final BukuController repository = new BukuController();
    // BookCard({Key? key, required this.buku}) : super(key: key);

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
                Navigator.push<Widget>(
                  context, MaterialPageRoute(builder: (context) {
                  // return DetailBuku(buku: buku);
                  return DetailPeminjaman();
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

  Widget bookHorizontalInfo(){
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 345,
          height: 600,
          child: Center(
            child: SizedBox(
              width: 380,
              height: 400,
              child: Card(
                  elevation: 7,
                  color: Color(0xFF888DF2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.white,
                          size: 100),
                      Text("TOTAL PEMINJAMAN ANDA",
                          style: TextStyle(
                            fontFamily: 'Sono',
                            color: Colors.white, fontSize: 20,
                          )),
                      Text("32",
                          style: TextStyle(
                            fontFamily: 'Sono',
                            color: Colors.white, fontSize: 30,
                          )),
                    ],
                  )
              ),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 345,
          height: 600,
          child: Center(
            child: SizedBox(
              width: 380,
              height: 400,
              child: Card(
                  elevation: 7,
                  color: Color(0xFF888DF2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_add, color: Colors.white,
                          size: 100),
                      Text("PINJAMAN BERLANGSUNG",
                          style: TextStyle(
                            fontFamily: 'Sono',
                            color: Colors.white, fontSize: 20,
                          )),
                      Text("3",
                          style: TextStyle(
                            fontFamily: 'Sono',
                            color: Colors.white, fontSize: 30,
                          )),
                    ],
                  )
              ),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 345,
          height: 600,
          child: Center(
            child: SizedBox(
              width: 380,
              height: 400,
              child: Card(
                elevation: 7,
                color: Color(0xFF888DF2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book, color: Colors.white,
                    size: 100),
                    Text("TOTAL BUKU SAAT INI",
                        style: TextStyle(
                            fontFamily: 'Sono',
                            color: Colors.white, fontSize: 20,
                        )),
                    Text("131",
                        style: TextStyle(
                          fontFamily: 'Sono',
                          color: Colors.white, fontSize: 30,
                        )),
                  ],
                  )
              ),
            ),
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }

}