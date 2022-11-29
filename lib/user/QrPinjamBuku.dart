
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

import '../model/peminjaman.dart';

class QrCodePinjam extends StatefulWidget {
  final Peminjaman peminjaman;
  QrCodePinjam({Key? key, required this.peminjaman}) : super(key: key);

  @override
  State<QrCodePinjam> createState() => _QrCodePinjamState(peminjaman);
}

class _QrCodePinjamState extends State<QrCodePinjam> {
  _QrCodePinjamState(this.peminjaman);
  final Peminjaman peminjaman;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F0CAD),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                QrCodeGen(),
                  SizedBox(height: 20,),
                  Align(
                    child: Text(
                      peminjaman.idpeminjaman, style: TextStyle(
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
                        "NPM Peminjam", style: TextStyle(
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
                       peminjaman.npm, style: TextStyle(
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
                        "Tanggal Peminjaman", style: TextStyle(
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
                        peminjaman.waktupinjam!.toDate().toString(), style: TextStyle(
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
                                  "ID Buku", style: TextStyle(
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
                                  peminjaman.IdBuku, style: TextStyle(
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
                                  "Status Pinjam", style: TextStyle(
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
                                  peminjaman.status, style: TextStyle(
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
          )
        )
      ),
    );
  }

  Widget QrCodeGen(){
    return QrImage(
      data: peminjaman.toJson().toString(),
      version: QrVersions.auto,
      size: 320,
      gapless: false,
      embeddedImage: AssetImage('assets/images/my_embedded_image.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(80, 80),
      ),
    );
  }

}
