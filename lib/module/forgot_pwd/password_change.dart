import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetScreen extends StatefulWidget {
  String? uid;
  ResetScreen(this.uid);
  @override
  ResetScreenState createState() => ResetScreenState();
}

class ResetScreenState extends State<ResetScreen> {
  var _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade500,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey.shade500,
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, right: 150),
              child: Text("Forgot Password ?",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    isDense: true,
                    labelText: "Enter Valid Email",
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    hintText: "Email field is required",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.attach_email,
                      color: Colors.white,
                      size: 20,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Valid Email-Id";
                    }
                    return null;
                  },
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    var emailvalidator = _email.text.toString();
                    print(emailvalidator);
                    auth.sendPasswordResetEmail(email: _email.text.toString());
                    print(_email);
                    snackBar("Email Verified Successful");
                  }
                },
                child: Text("Submit",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
              ),
            ),
            // InkWell(
            //   onTap: () async{
            //     if(_formkey.currentState!.validate())
            //       {
            //         var emailvalidator = _email.text.toString();
            //         print(emailvalidator);
            //         auth.sendPasswordResetEmail(email: _email.text.toString());
            //         print(_email);
            //       }
            //
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(top: 10),
            //     width: MediaQuery.of(context).size.width/1.4,
            //     height: 50,
            //     alignment: Alignment.center,
            //     child: Text("Submit",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18)),
            //     decoration: BoxDecoration(
            //       color: Colors.purple.shade400,
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  snackBar(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
