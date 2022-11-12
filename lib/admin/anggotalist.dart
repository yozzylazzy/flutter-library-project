import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/bukuController.dart';

class AnggotaList extends StatelessWidget {
  const AnggotaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
                Text("List Anggota"),
            ],
          ),
        ),
      ),
    );
  }
}

