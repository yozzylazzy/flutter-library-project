import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  // const HistoryPage({Key? key}) : super(key: key);
  HistoryPage(this.useruid);
  final String useruid;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Container(
              child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(90,0)),
                          ),
                        ),),
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(90,50)),
                          ),
                        ),),
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(90,50)),
                          ),
                        ),),
                        Expanded(child: Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFF5B61D9),
                            borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(90,0)),
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
                            Text("Buku Yang Selesai Dipinjam",textAlign: TextAlign.center, style:
                            TextStyle(
                                color: Colors.white, fontSize: 25,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat',
                            ),),
                            SizedBox(height: 5,),
                            Text("Buku Yang Selesai Dipinjam Baru-Baru Ini",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Sono',
                                  color: Colors.white, fontSize: 12,
                                )),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20.0),
                              height: 200.0,
                              child: Text("Hi"),
                            ),
                          ]),),
                  ]),
            ),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.only(left: 20, right: 20), child: Divider(
              color: Colors.grey,
              thickness: 2,
            ),),
            SizedBox(height: 20,),
            Align(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "LIST LENGKAP BUKU SELESAI DIPINJAM", style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                  ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
            SizedBox(height: 20,),
          ]),
    );
  }
}
