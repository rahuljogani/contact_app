import 'package:flutter/material.dart';
import 'package:untitled1/module/add_view_delete/Add/add_page.dart';
import 'package:untitled1/module/add_view_delete/Delete/restore_contact.dart';
import 'package:untitled1/module/add_view_delete/View/view.dart';
import 'package:untitled1/module/login/login_form.dart';

class Information extends StatefulWidget {
  String? uid;
  Information(this.uid);
  @override
  InformationState createState() => InformationState();
}

class InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text("USER"),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddPage('${widget.uid}')));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(17, 80, 17, 15),
                      width: double.infinity,
                      height: 70,
                      alignment: Alignment.center,
                      child: Text("ADD",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.brown.shade200,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DisplayScreen('${widget.uid}')));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(17, 80, 17, 15),
                      width: double.infinity,
                      height: 70,
                      alignment: Alignment.center,
                      child: Text("VIEW",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey.shade200,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Restoredata('${widget.uid}')));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(17, 80, 17, 15),
                      width: double.infinity,
                      height: 70,
                      alignment: Alignment.center,
                      child: Text("DELETE CONTACT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade100,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginForm()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("Logout",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
