import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/module/add_view_delete/user_list/user_contact.dart';
import 'package:untitled1/service/helper.dart';

class AddPage extends StatefulWidget {
  String? uid;

  AddPage(this.uid);

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  bool onTap = false;

  File? pickedImage;
  final picker = ImagePicker();
  var _formkey = GlobalKey<FormState>();
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();

  Helper helper = Helper();

  int? _groupValue = 0;

  void _checkRadio(int? index) {
    setState(() {
      _groupValue = index;
    });
  }

  // Future<QuerySnapshot> getImages(){
  //   var img = _img.toString();
  //   return FirebaseFirestore.instance.collection("user").get();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: onTap == true
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 25),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showPicker(context);
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xffFDCF09),
                          child: pickedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    pickedImage!,
                                    width: 300,
                                    height: 300,
                                    fit: BoxFit.fitHeight,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50)),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: pickedImage == null
                          ? Text(
                              "No Image is picked",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            )
                          : Container(),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(height: 17),
                            TextFormField(
                              controller: _fname,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blueGrey.shade100,
                                  isDense: true,
                                  labelText: "Enter First Name",
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  hintText: "Enter FirstName Here",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter FirstName";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _lname,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blueGrey.shade100,
                                  isDense: true,
                                  labelText: "Enter Last Name",
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  hintText: "Enter LastName Here",
                                  prefixIcon: Icon(
                                    Icons.perm_contact_cal,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter LastName";
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
                                } else if (value.length > 10) {
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
                              controller: _address,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blueGrey.shade100,
                                  isDense: true,
                                  labelText: "Enter Address",
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  hintText: "Enter Address Here",
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Address";
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
                                  child: Text('ADD CONTACT',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () async {
                                    // var imagename = DateTime.now().toString();
                                    // var snapshot = await FirebaseStorage.instance
                                    //     .ref()
                                    //     .child('images/' + imagename)
                                    //     .putFile(pickedImage!);
                                    // var downloadUrl =
                                    //     await snapshot.ref.getDownloadURL();
                                    // print(downloadUrl);
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        onTap = true;
                                      });
                                      var imagename = DateTime.now().toString();
                                      var snapshot = await FirebaseStorage
                                          .instance
                                          .ref()
                                          .child('images/' + imagename)
                                          .putFile(pickedImage!);
                                      var downloadUrl =
                                          await snapshot.ref.getDownloadURL();
                                      print(downloadUrl);
                                      // var image = pickedImage.toString();
                                      var fname = _fname.text.toString();
                                      var lname = _lname.text.toString();
                                      var number = _contact.text.toString();
                                      var email = _email.text.toString();
                                      var address = _address.text.toString();
                                      var gender = "";
                                      var uid = widget.uid;

                                      if (_groupValue == 0) {
                                        gender = "male";
                                      } else {
                                        gender = "female";
                                      }

                                      helper.add(downloadUrl, fname, lname,
                                          number, email, address, gender, uid);

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Information(widget.uid)));

                                      Fluttertoast.showToast(
                                          msg: "Contact Added Successfully",
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
                                      side: BorderSide(color: Colors.white)),
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
    );
  }

  Future _imgFromGallery() async {
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromCamera() async {
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //  _imgFromCamera() async {
  //    File _image = await ImagePicker.pickImage(
  //        source: ImageSource.camera, imageQuality: 50
  //    );
  //    setState(() {
  //      pickedImage = _image;
  //    });
  //  }
  //  _imgFromGallery() async {
  //    File _image = await  ImagePicker.pickImage(
  //        source: ImageSource.gallery, imageQuality: 50
  //    );
  //    setState(() {
  //      pickedImage = _image;
  //    });
  // }
  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
