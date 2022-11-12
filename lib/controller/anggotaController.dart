import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

//Dapatkan 1 info anggota
class GetAnggota extends StatelessWidget {
  final String documentId;

  GetAnggota(this.documentId);

  @override
  Widget build(BuildContext context) {
    //CollectionReference anggota = FirebaseFirestore.instance.collection("anggota").snapshots();
    CollectionReference anggota = FirebaseFirestore.instance.collection('anggota');

    return FutureBuilder<DocumentSnapshot>(
      future: anggota.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Selamat Datang, ${data['nama']}");
        }
        return Text("loading");
      },
    );
  }
}

// class Masuk extends StatelessWidget {
//   //const Masuk({Key? key}) : super(key: key);
//   final String user;
//   final String pass;
//   Masuk(this.user,this.pass);

  // @override
  // Widget build(BuildContext context) {
    // return StreamBuilder(
    //     stream: uservalidation,
    //     builder: (context, snapshot) {
    //       print(snapshot);
    //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    //       if (snapshot.hasData) {
    //         if (data['isApproved'] == false && data['isRequested'] == true) {
    //           print("loading...");
    //           return Text("loading....");
    //         } else if (data['isApproved'] == true &&
    //             data['isRequested'] == true) {
    //           print("Selamat Datang, ${data['npm']}");
    //           return Text("Selamat Datang, ${data['npm']}");
    //         }
    //       }
    //       // return ElevatedButton(
    //       //     onPressed: () {
    //       //       SendRequest()
    //       //           .updateUserData(isApproved: false, isRequested: true);
    //       //     },
    //       //     child: Text("Request Data"));
    //       return Text("loading");
    //     });

void onSearch() async {
  final String _collection = 'anggota';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  getData() async {
    return await _fireStore.collection(_collection).get();
  }

  //Ini sudah jalan dan berhasil untuk load user
  getData().then((val){
    if(val.docs.length > 0){
      print(val.docs[0].get("npm"));
      print(val.docs[0].get("nama"));
      print(val.docs[0].get("email"));
      print(val.docs[0].get("password"));
    }
    else{
      print("Not Found");
    }
  });
}

bool login(String user, String pass) {
  bool valid = false;
  final String _collection = 'anggota';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void _signIn() async {
    try {
      String updateuser = user + "@co.id";
      print(updateuser);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: updateuser,
          password: pass
      );
      if (updateuser != null) {
        print("success");
        valid = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  return valid;
}

// try {
// UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
// email: "barry.allen@example.com",
// password: "SuperSecretPassword!"
// );
// } on FirebaseAuthException catch (e) {
// if (e.code == 'weak-password') {
// print('The password provided is too weak.');
// } else if (e.code == 'email-already-in-use') {
// print('The account already exists for that email.');
// }
// } catch (e) {
// print(e);
// }
//   getData() async {
//     return await _fireStore.collection(_collection).get();
//   }
//
//   //Ini sudah jalan dan berhasil untuk load user
//   await getData().then((val){
//     if(val.docs.length > 0){
//       for(int x = 0; x <=val.docs.length; x++){
//         if(val.docs[x].get("npm") == user.toString()){
//           print(user);
//           if(val.docs[x].get("password") == pass){
//             print(pass);
//             print(val.docs[x].get("password"));
//             valid = true;
//           }
//         }
//         print(val.docs[x].get("npm"));
//         // print(val.docs[x].get("nama"));
//         // print(val.docs[x].get("email"));
//         // print(val.docs[x].get("password"));
//       }
//       // print(val.docs[0].get("npm"));
//       // print(val.docs[0].get("nama"));
//       // print(val.docs[0].get("email"));
//       // print(val.docs[0].get("password"));
//     }
//     else{
//       print("Not Found");
//     }
//   });
//   return valid;

// class LogIn {
//   // Future<List<Model>> getReviews(String id) {
//   //   try {
//   //     QuerySnapshot querySnapshot=await _collectionReference.doc(id).collection('reviews').orderBy('date', descending: true).get();
//   //
//   //     List<Model> result;
//   //     querySnapshot.docs.forEach((doc) {
//   //       print(doc["first_name"]);
//   //       result.add(Model.fromJson(review.data()));
//   //     });
//   //     return result;
//   //
//   //   } catch (error) {
//   //     return error.message;
//   //   }
//
//   final String user;
//   final String pass;
//
//   LogIn(this.user,this.pass);
//
//   bool loginvalidate() {
//     bool login = false;
//     final anggota = FirebaseFirestore.instance.collection("anggota");
//     Stream uservalidation = anggota.where("npm", isEqualTo: user).snapshots();
//     Stream loginvalidation = anggota.where("password", isEqualTo: pass).snapshots();
//     print(uservalidation);
//     print(loginvalidation);
//     if(uservalidation!=null){
//       if(loginvalidation!=null){
//         login = true;
//       }
//     }
//     return login;
//   }
// }