import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/module/Update/update_data.dart';
import 'package:untitled1/module/add_view_delete/Delete/restore_contact.dart';
import 'package:untitled1/service/helper.dart';

class DisplayScreen extends StatefulWidget {
  String? uid;

  DisplayScreen(this.uid);

  @override
  DisplayScreenState createState() => DisplayScreenState();
}

class DisplayScreenState extends State<DisplayScreen> {
  Helper helper = Helper();

  // getData() async{
  //   String userId = (await FirebaseAuth.instance.currentUser!).uid;
  //   return FirebaseFirestore.instance.collection('users').doc(widget.uid);
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }
  //   var user = firebase.auth().currentUser;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("View Screen"),
      ),
      body: StreamBuilder(
        // stream: FirebaseFirestore.instance.collection("user")
        //     .where("Uid", "==", firebase.auth().currentUser.uid)
        //     .get
        // }
        stream: FirebaseFirestore.instance
            .collection('user')
            .where("Uid", isEqualTo: widget.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("No Data Found"),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return InkWell(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      // border: Border(
                      //     bottom: BorderSide(
                      //       color: Colors.blueGrey.shade800,
                      //     )
                      // ),
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(
                        color: Colors.blueGrey,
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        // radius: 20.0,
                        // backgroundColor: Colors.blueGrey.shade700,
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
                          Text("Contact No : " + document["Contact"].toString(),
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
                                  color: Colors.red,
                                  onPressed: () async {
                                    AlertDialog alert = new AlertDialog(
                                      title: Text("Warning!"),
                                      content: Text("Are You Sure?"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection('restore')
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
                                                .collection('user')
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
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blueGrey[500],
                                  onPressed: () async {
                                    AlertDialog alert = new AlertDialog(
                                      title: Text("Warning!"),
                                      content: Text("Are You Sure?"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () async {
                                            var singleid =
                                                document.id.toString();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        UpdateScreen(widget.uid,
                                                            singleid)));
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
