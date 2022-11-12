// import 'package:flutter/cupertino.dart';
//
// class UserHome extends StatelessWidget {
//   const UserHome({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: Column(
//           children: [
//             Text("Ini Personal State User"),
//             Text("Ini Personal Status User"),
//             Text("Ini Wishlish"),
//             Text("Ini Pawdawd"),
//             Text("awdawd")
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _UserHomeState extends StatefulWidget {
//   const _UserHomeState({Key? key}) : super(key: key);
//
//   @override
//   State<_UserHomeState> createState() => _UserHomeStateState();
// }
//
// class _UserHomeStateState extends State<_UserHomeState> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';

class HomeUser extends StatelessWidget {
  HomeUser(this.useruid);
  final String useruid;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.jpg'),
                radius: 40,
              ),
            ),
            Divider(
              height: 60,
              color: Colors.grey[800],
            ),
            Text(
              'Name',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future:
              FirebaseFirestore.instance.collection('anggota').
              doc(useruid).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    "${data['nama']}",
                    style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                    ),
                  );
                }
                return Text(
                  'Loading...',
                  style: TextStyle(
                      color: Colors.amberAccent[200],
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                );
              },),
            SizedBox(height: 30),
            Text(
              'Jenjang',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future:
              FirebaseFirestore.instance.collection('anggota').
              doc(useruid).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    "${data['jenjang']}",
                    style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 2,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                    ),
                  );
                }
                return Text(
                  "Loading...",
                  style: TextStyle(
                      color: Colors.amberAccent[200],
                      letterSpacing: 2,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                );
              },),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'your@mail.com',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18,
                      letterSpacing: 1
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }

  void loadUserData(String uid) async{
     GetAnggota(uid);
  }

}
