import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uas_2020130002/admin/appadmin.dart';
import 'package:uas_2020130002/controller/anggotaController.dart';
import 'package:uas_2020130002/user/appuser.dart';
import 'package:uas_2020130002/user/homelibrary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:animate_gradient/animate_gradient.dart';

void main() async {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Sono',
        hoverColor: Colors.purple
      ),
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
  FirebaseFirestore dbanggota = FirebaseFirestore.instance;

  bool _passwordVisible = true;
  //
  @override
  void initState(){
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            elevation: 40,
            color: Colors.deepPurple,
            child: Container(
              height: 30,
              child: Center(
                child: Text("Created By @yozzylazzy",
                  textAlign: TextAlign.center,style:
                  TextStyle(color: Colors.white, shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 1.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3.0,
                      color: Color.fromARGB(125, 0, 0, 255),
                    ),
                  ],),),
              ),
            ),
          ),
            backgroundColor: Colors.white,
            body:
            AnimateGradient(
            primaryBegin: Alignment.topLeft,
            primaryEnd: Alignment.bottomLeft,
            secondaryBegin: Alignment.bottomRight,
            secondaryEnd: Alignment.topRight,
            primaryColors: const [
            Colors.tealAccent,
            Colors.greenAccent,
            Colors.white,
            ],
            secondaryColors: const [
            Colors.white,
            Colors.lightBlueAccent,
            Colors.blue,
            ],
            child: SingleChildScrollView(child:
            Center(
              child: Form(
                key: _keyform,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        ClipPath(
                            child: Container(
                              height: 350,
                              width: double.infinity,
                              decoration:  BoxDecoration(
                                  color: Colors.transparent,
                                  image:  DecorationImage(image: AssetImage("assets/images/background.png"),
                                      fit: BoxFit.fill)
                              ),
                              child:  Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Container(
                                    width: 400,
                                    child: Image.asset("assets/images/login.png",
                                        fit: BoxFit.cover),
                                  )
                              ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 70,left: 40
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child:  Text("Welcome To",style:
                                TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w500, fontSize: 20,
                                    fontFamily: 'Sono'),textAlign: TextAlign.left,),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("M-Library",style:
                                TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w900, fontSize: 35,
                                    fontFamily: 'Sono'),),
                              )
                            ],
                          )
                        )
                      ],
                    ),
                    
                    SizedBox(height: 30,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
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
                          hintText: 'Enter Your NPM',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: pass,
                        validator: (value){
                          if(value==null||value==''){
                            return "Password Tidak Boleh Dikosongkan";
                          }
                        },
                        obscureText: !_passwordVisible,
                        autocorrect: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: (){
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35,),
                    Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () {
                          String admCheck = user.text.toString()+"%@!%";
                          String passadmCheck = pass.text.toString()+"%@!%";
                          print("keypressed");
                          if(_keyform.currentState!.validate()){
                            if (admCheck == "admin%@!%" && passadmCheck == "admin%@!%") {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context){
                                return AppAdmin();
                              }
                              ));
                            } else {
                              validateLogin(user.text,pass.text);
                            }
                          }
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 25,
                          fontFamily: 'Montserrat', fontWeight: FontWeight.w900,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1, 2),
                                  blurRadius: 1.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Shadow(
                                  offset: Offset(1, 2),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(125, 0, 0, 255),
                                ),
                              ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          minimumSize: const Size.fromHeight(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
            ),
            )
        ),
        onWillPop: () async {
             return true;
           }
        );
  }

  void validateLogin(String user, String pass) async {
    bool valid = false;
    final _auth = FirebaseAuth.instance;
    try {
        String updateuser = user + "@co.id";
        //print(updateuser);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: updateuser,
            password: pass
        );
        if (updateuser != null) {
          print("success");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) {
              return AppUser(userCredential.user!.uid.toString());
            }),);
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          showDialog(context: context, builder: (context){
            return AlertDialog(title: Column(
              children: [
                SizedBox(
                    child: Icon(Icons.dangerous_outlined, color: Colors.red,size: 45,)),
                SizedBox(height: 10,),
                SizedBox(child: Text('GAGAL LOGIN!',
                  style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
                SizedBox(height: 10,),
                Divider(thickness: 4,color: Colors.deepPurple,
                )
              ],
            ), content: Text("Pengguna Tidak Ditemukan/Terdaftar!",
                  style: TextStyle(fontFamily: 'Montserrat', fontWeight:
                  FontWeight.w700)), actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("OK"))
            ],
            );});
          // ScaffoldMessenger.of(context).showSnackBar(const
          //       SnackBar(content: Text("Pengguna Tidak Ditemukan")));
        } else if (e.code == 'wrong-password') {
          showDialog(context: context, builder: (context){
            return AlertDialog(title: Column(
              children: [
                SizedBox(
                    child: Icon(Icons.warning_amber, color: Colors.orangeAccent,size: 45,)),
                SizedBox(height: 10,),
                SizedBox(child: Text('PASSWORD SALAH!',
                  style: TextStyle(fontFamily: 'Sono',fontWeight: FontWeight.w800),)),
                SizedBox(height: 10,),
                Divider(thickness: 4,color: Colors.deepPurple,
                )
              ],
            ), content: Text("Pengguna dengan Password Tidak Sesuai!",
                style: TextStyle(fontFamily: 'Montserrat', fontWeight:
                FontWeight.w700)), actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("OK"))
            ],
            );});
          // print('Wrong password provided for that user.');
          // ScaffoldMessenger.of(context).showSnackBar(const
          // SnackBar(content: Text("Password Salah...")));
        }
      }
    }
}

