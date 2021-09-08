import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/module/Update/update_data.dart';
import 'package:untitled1/module/add_view_delete/View/view.dart';

class Restoredata extends StatefulWidget {
  String? uid;

  Restoredata(this.uid);

  @override
  RestoredataState createState() => RestoredataState();
}

class RestoredataState extends State<Restoredata> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Contact"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('restore')
            .where("Uid", isEqualTo: widget.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot.hashCode);
          if (!snapshot.hasData) {
            return Center(
              child: Text("No Data Found"),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return InkWell(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      // border: Border(
                      //     bottom: BorderSide(
                      //       color: Colors.blueGrey.shade800,
                      //     )
                      // ),
                      color: Colors.blueGrey.shade100,
                      // borderRadius: BorderRadius.circular(80),
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(
                        color: Colors.black45,
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 60,
                        height: 50,
                        child: Image.network(document["ContactImage"]),
                        // child: Text(document["Firstname"].toString().toUpperCase()[0],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      title: Text(
                          "Firstname : " + document["Firstname"].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      subtitle: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Lastname : " + document["Lastname"].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Text("Contact : " + document["Contact"].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Text("Email : " + document["Email"].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Text("Gender : " + document["Gender"].toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: InkWell(
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.lightGreen,
                                  onPressed: () async {
                                    AlertDialog alert = new AlertDialog(
                                      title: Text("Warning!"),
                                      content: Text("Are You Sure?"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection('restore')
                                                .doc(document.id)
                                                .delete();
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.black45,
                                          child: Text("YES",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        RaisedButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.black45,
                                          child: Text("No",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    );
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        });
                                  },
                                ),
                                focusColor: Colors.brown,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Container(
                              child: InkWell(
                                child: IconButton(
                                  icon: const Icon(Icons.restore),
                                  color: Colors.blueGrey,
                                  onPressed: () async {
                                    AlertDialog alert = new AlertDialog(
                                      title: Text("Warning!"),
                                      content: Text("Are You Sure?"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection('user')
                                                .add({
                                              'ContactImage':
                                                  document["ContactImage"],
                                              'Firstname':
                                                  document["Firstname"],
                                              'Lastname': document["Lastname"],
                                              'Contact': document["Contact"],
                                              'Email': document["Email"],
                                              'Address': document["Address"],
                                              'Gender': document["Gender"],
                                              'Uid': widget.uid
                                            });
                                            FirebaseFirestore.instance
                                                .collection('restore')
                                                .doc(document.id)
                                                .delete();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        DisplayScreen(
                                                            widget.uid)));
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.black45,
                                          child: Text("YES",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        RaisedButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.black45,
                                          child: Text("No",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    );
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        });
                                  },
                                ),
                                focusColor: Colors.brown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
