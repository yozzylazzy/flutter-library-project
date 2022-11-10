import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/user/user.dart';

class HomeLibrary extends StatelessWidget {
  // const HomeLibrary({Key? key}) : super(key: key);
  HomeLibrary(this.useruid);
  final String useruid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
          child: Column(
            children: [
              GetAnggota(useruid),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                height: 200,
                child: Card(
                  elevation: 5,
                  child: Column(
                        children: [
                            Center(child: Text("Selamat Datang di Mobile"
                                " Library STMIK LIKMI", textAlign: TextAlign.center,),),
                          SizedBox(height: 20,),
                          Center(child: Text("Halo, Budi Santoso", textAlign: TextAlign.center,),),
                        ],
                ),
              ),
              ), //Sambutan Selamat Datang
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
                    Expanded(child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.collections_bookmark),
                          Center(child: Text("Total Peminjaman Bulan Ini", textAlign: TextAlign.center,),),
                          Text("430")
                        ],
                      ),
                    )),
                  ],
                ),
              ), //Status Buku Pada Perpustakaan
              SizedBox(height: 20,),
               bookCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookCard(){
    return Row(
      children: [
        Expanded(
        child: SizedBox(
          height: 300,
          child: new GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
                  , childAspectRatio: 0.7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10), itemBuilder: (context, index){
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
