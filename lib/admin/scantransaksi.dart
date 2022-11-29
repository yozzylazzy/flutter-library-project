// import 'dart:html';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uas_2020130002/model/peminjaman.dart';

class ScanTransaksi extends StatelessWidget {
  const ScanTransaksi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRCodeReader();
  }
}

class QRCodeReader extends StatefulWidget {
  const QRCodeReader({Key? key}) : super(key: key);

  @override
  State<QRCodeReader> createState() => _QRCodeReaderState();
}

class _QRCodeReaderState extends State<QRCodeReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  Peminjaman? peminjaman;
  String cekID = "-";
  @override
  void reassemble(){
    super.reassemble();
    if(Platform.isAndroid){
      controller!.pauseCamera();
    } else if (Platform.isIOS){
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key : qrKey,
              onQRViewCreated: _onQrViewCreated
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null) ? Text("Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}")
              : Text("Scan a QRCode"),
            ),
          ),
          Text(cekID),
        ],
      ),
    );
  }

  void _onQrViewCreated(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData){
      setState(() {
        result = scanData;
        // setState(() {
        //   Map<String, dynamic> jsonData = jsonDecode(result!.code.toString());
        //   peminjaman = Peminjaman.fromJson(jsonData);
        // });
      });
    });
  }

  @override
  void initState() {
    cekID = updateClass().toString();
    super.initState();
  }

  Future<String> updateClass() async {
    // peminjaman = jsonDecode(result.toString());
    String a ="tidak terbaca";
    if(result!=null){
      Map<String, dynamic> jsonData = await jsonDecode(result!.code.toString());
      // await jsonData.true.then((snapshot) {
      //   npm = snapshot['npm'];
      //   setState(() {
      //     idmember = npm;
      //   });
      // });
      peminjaman = Peminjaman.fromJson(jsonData);
    } else {
      peminjaman = new Peminjaman(a
          , "IdBuku", "npm", Timestamp.now(), Timestamp.now(), "status");
    }
    return peminjaman!.idpeminjaman.toString();
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

}

