// import 'dart:html';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text("Hello"),
          ),

        ],
      ),
    );
  }
}

