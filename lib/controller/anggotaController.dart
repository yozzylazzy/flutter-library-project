import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetAnggota extends StatelessWidget {
  final String documentId;

  GetAnggota(this.documentId);

  @override
  Widget build(BuildContext context) {
    //CollectionReference anggota = FirebaseFirestore.instance.collection("anggota").snapshots();
    CollectionReference anggota = FirebaseFirestore.instance.collection('anggota');

    return FutureBuilder<DocumentSnapshot>(
      future: anggota.doc("documentId").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
            print(snapshot);
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['nama']}");
        }

        return Text("loading");
      },
    );
  }
}