import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/module/add_view_delete/user_list/user_contact.dart';
import 'package:untitled1/module/forgot_pwd/password_change.dart';
import 'package:untitled1/module/register/registration_form.dart';

class LoginForm extends StatefulWidget {
  String? uid;
  LoginForm({this.uid});
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text("Login Form"),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 100, 15, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                        color: Colors.brown.shade100,
                        borderRadius: BorderRadius.circular(25)),
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text("Login Here",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                SizedBox(height: 18),
                                TextFormField(
                                  controller: _email,
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.blueGrey.shade100,
                                      isDense: true,
                                      labelText: "Enter Email",
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      hintText: "Enter Email Here",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                      )),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter valid Email-Id";
                                    }
                                    return null;
                                    // bool validEmail = RegExp(
                                    //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    //     .hasMatch(value ?? '');
                                    // if (value == null || value == '') {
                                    //   return "Please enter email id";
                                    // } else if (validEmail == false) {
                                    //   return "Please enter valid email id";
                                    // }
                                    // return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _password,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.blueGrey.shade100,
                                    isDense: true,
                                    labelText: "Enter Password",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    hintText: "Enter Password Here",
                                    prefixIcon: Icon(
                                      Icons.security,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  child: ButtonTheme(
                                    minWidth: 200.0,
                                    height: 50.0,
                                    child: RaisedButton(
                                      child: Text('Login',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          var uname = _email.text.toString();
                                          var pwd = _password.text.toString();

                                          print("Uname:" + uname);
                                          print("Password:" + pwd);
                                          _signInWithEmailAndPassword();
                                          // helper.login(uname, pwd, context);
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Registartion()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Don't have an account ? ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            // style: DefaultTextStyle.of(context).style,
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text: 'Register Here',
                                                  style: TextStyle(
                                                      color: Colors.indigo,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                SizedBox(height: 15),
                                InkWell(
                                  onTap: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ResetScreen(widget.uid)));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Forgot Password ?",
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      print("user");
      if (userCredential.user != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                Information('${userCredential.user?.uid}')));
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == null) {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}
