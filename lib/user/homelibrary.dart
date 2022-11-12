import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/user/user.dart';
import 'package:filter_list/filter_list.dart';

import '../model/bukumodel.dart';

class Home extends StatelessWidget {
  Home(this.useruid);
  final String useruid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeLibrary(useruid),
    );
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
          child: Column(
            children: [
              GetAnggota(widget.useruid),
              SizedBox(height: 20,),
              Container(
                height: 100,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Card(
                      elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.collections_bookmark),
                            Text("Total Buku Saat Ini"),
                            Text("670")
                          ],
                        ),
                    )),
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
               bookCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookCard() {
    return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 400,
              child: new GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
                      , childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Text("Ini Buku ke- ${index}"),
                    );
                  }
              ),
            ),
          )
        ]
    );
  }
}







