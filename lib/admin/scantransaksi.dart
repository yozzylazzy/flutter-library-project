// import 'dart:html';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uas_2020130002/admin/editbuku.dart';
import 'package:uas_2020130002/admin/edittransaksi.dart';
import 'package:uas_2020130002/controller/transaksiController.dart';
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
  String statusdb = "";
  String documentID = "";
  String cekID = "-";
  TransaksiController repotrans = new TransaksiController();
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('transaksi');

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

  Future<void> getValidasiStatusBuku(String docid) async {
    DocumentReference documentReference = collectionReference.doc(docid);
    String status = '';
    await documentReference.get().then((snapshot) {
      status = snapshot['status'];
      setState(() {
        statusdb = status;
      });
    });
  }

  void _onQrViewCreated(QRViewController controller){
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(()  {
        result = scanData;
      });
      if(result?.format == BarcodeFormat.qrcode){
        controller.pauseCamera();
        try {
          Peminjaman peminjaman = Peminjaman.fromQRJson(jsonDecode(result?.code ?? ""));
          setState(() {
            documentID = peminjaman.npm+peminjaman.IdBuku+peminjaman.idpeminjaman;
          });
          if(peminjaman.status=="dipesan"){
              peminjaman.status = "dipinjam";
              showDialog(context: context, builder: (_) => dialogUpdateStatus(context));
          } else if (peminjaman.status=="dipinjam"){
              peminjaman.status="selesai";
              peminjaman.waktukembali = DateTime.now();
              showDialog(context: context, builder: (_) => dialogUpdateKembali(context));
          } else {
            showDialog(context: context, builder: (_) => dialogQRTidakValid(context));
          }
          repotrans.updateTransaksi(peminjaman);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("QR Terbaca! ${statusdb}"))
          );
          // showDialog(context: context, builder: (_) => dialogUpdateStatus(context));

          // Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) =>
          //             EditTransaksi(peminjaman: peminjaman)
          //     )
          // ).then((value) =>
          //   controller.resumeCamera()
          // );
        }
        on FormatException {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text("QR Code Tidak Valid!"))
          );
        }
        on Exception {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text("ERROR!"))
          );
        } catch (e, stacktrace){
          StackTrace.current;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("ERROR! $e, Caught! $stacktrace"))
          );
        }
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text("HAH!"))
        );
      }
    });
  }

  Widget dialogUpdateStatus(BuildContext context){
    return AlertDialog(title: Column(
      children: [
        SizedBox(
            child: Icon(Icons.info, color: Colors.blueAccent,size: 45,)),
        SizedBox(height: 10,),
        SizedBox(child: Text('UPDATE BUKU DIPINJAM',
          style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
        SizedBox(height: 10,),
        Divider(thickness: 4,color: Colors.deepPurple,
        )
      ],
    ), content: Text("Buku telah diserahkan kepada peminjam dan status akan diupdate menjadi dipinjam",
        style: TextStyle(fontFamily: 'Montserrat', fontWeight:
        FontWeight.w700)), actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
        // if(peminjaman!.status=="dipesan"){
        //   peminjaman!.status = "dipinjam";
        // } else if (peminjaman!.status=="dipinjam"){
        //   peminjaman!.status="selesai";
        // }
        // repotrans.updateTrans(peminjaman!);
      }, child: Text("OK")),
    ],
    );
  }

  Widget dialogQRTidakValid(BuildContext context){
    return AlertDialog(title: Column(
      children: [
        SizedBox(
            child: Icon(Icons.dangerous, color: Colors.red,size: 45,)),
        SizedBox(height: 10,),
        SizedBox(child: Text('QR CODE TIDAK VALID',
          style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
        SizedBox(height: 10,),
        Divider(thickness: 4,color: Colors.deepPurple,
        )
      ],
    ), content: Text("QR Code tidak valid atau sudah kadaluarsa, mohon perbaharui status melalui petugas"
        " perpustakaan",
        style: TextStyle(fontFamily: 'Montserrat', fontWeight:
        FontWeight.w700)), actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
        // if(peminjaman!.status=="dipesan"){
        //   peminjaman!.status = "dipinjam";
        // } else if (peminjaman!.status=="dipinjam"){
        //   peminjaman!.status="selesai";
        // }
        // repotrans.updateTrans(peminjaman!);
      }, child: Text("OK")),
    ],
    );
  }

  Widget dialogUpdateKembali(BuildContext context){
    return AlertDialog(title: Column(
      children: [
        SizedBox(
            child: Icon(Icons.check_circle, color: Colors.green,size: 45,)),
        SizedBox(height: 10,),
        SizedBox(child: Text('UPDATE BUKU SELESAI',
          style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
        SizedBox(height: 10,),
        Divider(thickness: 4,color: Colors.deepPurple,
        )
      ],
    ), content: Text("Buku telah diterima oleh petugas perpustakaan dan status akan diupdate menjadi selesai",
        style: TextStyle(fontFamily: 'Montserrat', fontWeight:
        FontWeight.w700)), actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
        // if(peminjaman!.status=="dipesan"){
        //   peminjaman!.status = "dipinjam";
        // } else if (peminjaman!.status=="dipinjam"){
        //   peminjaman!.status="selesai";
        // }
        // repotrans.updateTrans(peminjaman!);
      }, child: Text("OK")),
    ],
    );
  }

  @override
  void initState() {
    super.initState();
    getValidasiStatusBuku(documentID);
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

}

