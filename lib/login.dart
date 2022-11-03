import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130002/user/appuser.dart';
import 'package:uas_2020130002/user/homelibrary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}
  final TextEditingController user = TextEditingController();
  final TextEditingController pass = TextEditingController();

class _Login extends State<Login> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child:Center(
        child: Form(
          key: _keyform,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: user,
                  validator: (value){
                    if(value==null || value==''){
                      return "Username Tidak Boleh Kosong!";
                    }
                  },
                  readOnly: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Username',
                    hintText: 'Enter Your Username/Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: pass,
                  validator: (value){
                    if(value==null||value==''){
                      return "Password Tidak Boleh Dikosongkan";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      hintText: 'Enter Your Password'),
                ),
              ),
              SizedBox(height: 20,),
              TextButton(
                onPressed: (){
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    if (user.text == "admin" && pass.text == "admin") {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context){
                        // if(_keyform.currentState!.validate()){
                        //   ScaffoldMessenger.of(context).showSnackBar(const
                        //   SnackBar(content: Text("Gagal Login....")));
                        // }else

                        return AppUser();
                      }));
                    }

                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size.fromHeight(30),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
        ),
      )
    );
  }

  void validateLogin(){
    if(_keyform.currentState!.validate()){
      FirebaseFirestore anggota = FirebaseFirestore.instance;

    }
  }
}

