import 'package:flutter/cupertino.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text("Ini Personal State User"),
            Text("Ini Personal Status User"),
            Text("Ini Wishlish"),
            Text("Ini Pawdawd"),
            Text("awdawd")
          ],
        ),
      ),
    );
  }
}

class _UserHomeState extends StatefulWidget {
  const _UserHomeState({Key? key}) : super(key: key);

  @override
  State<_UserHomeState> createState() => _UserHomeStateState();
}

class _UserHomeStateState extends State<_UserHomeState> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

