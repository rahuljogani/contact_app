import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Helper{

  void add(downloadUrl,fname,lname,number,email,address,gender,uid){
    FirebaseFirestore.instance.collection('user').add({'ContactImage':downloadUrl,'Firstname':fname,'Lastname':lname,'Contact':number,'Email':email,'Address':address,'Gender':gender,'Uid':uid});
  }

  void update(downloadUrl,fname,lname,number,email,address,gender,singledata){
    FirebaseFirestore.instance.collection('user').doc(singledata).update({'ContactImage':downloadUrl,'Firstname':fname,'Lastname':lname,'Contact':number,'Email':email,'Address':address,'Gender':gender}).then((_){
      print("Update Successful----->>");
      Fluttertoast.showToast(
          msg: "Update Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

}

