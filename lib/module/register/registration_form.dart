import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/module/login/login_form.dart';
import 'package:untitled1/service/helper.dart';

class Registartion extends StatefulWidget {
  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<Registartion> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _formkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpwd = TextEditingController();

  // Helper helper = Helper();

  int? _groupValue = 0;
  bool? _isSuccess;

  void _checkRadio(int? index) {
    setState(() {
      _groupValue = index;
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _email.dispose();
    _password.dispose();
    _confirmpwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("User Registration"),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 35, 15, 15),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                          child: Text("Register Here",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                        SizedBox(height: 17),
                        TextFormField(
                          controller: _name,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueGrey.shade100,
                              isDense: true,
                              labelText: "Enter Name",
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              hintText: "Enter Name Here",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          maxLength: 10,
                          controller: _contact,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blueGrey.shade100,
                            isDense: true,
                            labelText: "Enter Number",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            hintText: "Enter Number Here",
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please enter mobile number";
                            } else if (value.length < 10) {
                              return "Please enter valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _email,
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
                                Icons.email,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                              )),
                          validator: (value) {
                            bool validEmail = RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value ?? '');
                            if (value == null || value == '') {
                              return "Please enter email id";
                            } else if (validEmail == false) {
                              return "Please enter valid email id";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          controller: _password,
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
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          controller: _confirmpwd,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueGrey.shade100,
                              isDense: true,
                              labelText: "Enter Confirm Password",
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              hintText: "Enter Confirm Password",
                              prefixIcon: Icon(
                                Icons.vpn_key,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Confirm Password";
                            }
                            if (_password.text != _confirmpwd.text) {
                              return "Password Does Not Match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Gender"),
                            Radio(
                              value: 0,
                              groupValue: _groupValue,
                              onChanged: _checkRadio,
                              activeColor: Colors.blueGrey,
                            ),
                            Text("Male"),
                            Radio(
                                value: 1,
                                groupValue: _groupValue,
                                onChanged: _checkRadio,
                                activeColor: Colors.blueGrey),
                            Text("Female"),
                          ],
                        ),
                        InkWell(
                          child: ButtonTheme(
                            minWidth: 200,
                            height: 50,
                            child: RaisedButton(
                              child: Text('Register',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              color: Colors.blueGrey,
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  var name = _name.text.toString();
                                  var number = _contact.text.toString();
                                  var email = _email.text.toString();
                                  var password = _password.text.toString();
                                  var confirm = _confirmpwd.text.toString();
                                  var gender = "";
                                  var userlist = [];

                                  if (_groupValue == 0) {
                                    gender = "male";
                                  } else {
                                    gender = "female";
                                  }

                                  // helper.register(name, number, email, password, confirm, gender,userlist);

                                  // FirebaseFirestore.instance.collection('user').add({'Name':name,'Contact':number,'Email':email,'Password':password,'Confirmpwd':confirm,'Gender':gender});
                                  _registerAccount();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginForm()));
                                  Fluttertoast.showToast(
                                      msg: "Register Successful",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerAccount() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      if (userCredential.user == null) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => LoginForm()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
