import 'package:flutter/material.dart';
import 'package:uas_2020130002/admin/addbuku.dart';

class BukuList extends StatelessWidget {
  const BukuList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) {
            return AddBuku();
          }),);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
