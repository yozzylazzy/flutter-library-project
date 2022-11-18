
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QrCodePinjam extends StatefulWidget {
  const QrCodePinjam({Key? key}) : super(key: key);

  @override
  State<QrCodePinjam> createState() => _QrCodePinjamState();
}

class _QrCodePinjamState extends State<QrCodePinjam> {
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
                        "Nama Peminjam", style: TextStyle(
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
                        "Rekswa Wasdbwb", style: TextStyle(
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
                        DateTime.now().toString(), style: TextStyle(
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
          )
        )
      ),
    );
  }

  Widget QrCodeGen(){
    return QrImage(
      data: 'This QR code has an embedded image as well',
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
