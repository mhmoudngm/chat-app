import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newmessage extends StatefulWidget {
  @override
  _newmessageState createState() => _newmessageState();
}

class _newmessageState extends State<newmessage> {
  var mes = '';


  final _controller = TextEditingController();

  sentmessage() async {
    final user = await FirebaseAuth.instance.currentUser;
    final userdata  = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    //FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection("chat")
        .add({
      "text": mes,
      "createdat": Timestamp.now(),
      "username": userdata["username"],
      "userid":user.uid,
      "userimage":userdata["imageurl"]
    });
    _controller.clear();
    setState(() {
      mes="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: ("sent a message...")),
            onChanged: (val) {
              setState(() {
                mes = val;
              });
            },
          )),
          IconButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Colors.grey,
              onPressed: mes.trim().isEmpty ? null : sentmessage,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
