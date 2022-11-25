// import 'dart:html';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
          )
        ],
      ),
    );
  }

  void _onQrViewCreated(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData){
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

}

