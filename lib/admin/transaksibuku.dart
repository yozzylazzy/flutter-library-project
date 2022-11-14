import 'package:flutter/material.dart';

class TransaksiBukuList extends StatelessWidget {
  const TransaksiBukuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: (){
      // Navigator.push(
      //   context, MaterialPageRoute(builder: (context) {
      //   return
      // }),);
        },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
        ),
      body: Container(
        child: Text("List Transaksi..."),
      ),
    );
  }
}
