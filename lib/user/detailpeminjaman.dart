import 'package:flutter/material.dart';

class DetailPeminjaman extends StatelessWidget {
  const DetailPeminjaman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F0CAD),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: (){},
        icon : Icon(Icons.bookmark_add),
        label: Text("PINJAM BUKU"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                backgroundDetail(),
              ],
            ),
            SizedBox(height: 120,),
            Container(
              child: Column(
                children: [
                  Align(
                    child: Text(
                      "INI JUDUL BUKU", style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 35,),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Deskripsi Buku", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                      textAlign: TextAlign.left,
                    ),
                  ),),
                  SizedBox(height: 2,),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Abcdsawk aWdaskdwk Adskawdak", style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),),
                  SizedBox(height: 15,),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pengarang Buku", style: TextStyle(
                        fontFamily: 'Montserrat',fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),),
                  SizedBox(height: 2,),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Budi Santoso Gunawan", style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                        textAlign: TextAlign.left,
                      ),
                    ),),
                  SizedBox(height: 15,),
                  Padding(padding: EdgeInsets.only(left: 30, right: 30),
                    child: Divider(height: 2,color: Colors.grey,),),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Flexible(
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 30, right: 30),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Tahun Terbit Buku", style: TextStyle(
                                    fontFamily: 'Montserrat',fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),),
                              SizedBox(height: 2,),
                              Padding(padding: EdgeInsets.only(left: 30, right: 30),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "2022", style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                  ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),),
                              SizedBox(height: 15,),
                            ],
                          ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 30, right: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Halaman Buku", style: TextStyle(
                                  fontFamily: 'Montserrat',fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                                  textAlign: TextAlign.left,
                                ),
                              ),),
                            SizedBox(height: 2,),
                            Padding(padding: EdgeInsets.only(left: 30, right: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "100", style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                ),
                                  textAlign: TextAlign.left,
                                ),
                              ),),
                            SizedBox(height: 15,),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget backgroundDetail(){
    return Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                Flexible(child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF5B61D9),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(200,150)),
                  ),
                ),),
              ],
            ),
            Positioned(
                top: 30,
                left: 10, right: 10,
                child:
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      height: 350.0,
                      child: Center(
                        child: Image.asset("assets/images/bukulist.png"),
                      ),
                    ),
                  ],
                )
            ),
          ],
        )
    );
  }
}
