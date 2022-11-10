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

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/user.jpg'),
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
            Text(
              'Keith Chasen',
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Level',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2
              ),
            ),
            SizedBox(height: 10),
            Text(
              '8',
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),
            ),
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
                  'keith@mail.com',
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
}
