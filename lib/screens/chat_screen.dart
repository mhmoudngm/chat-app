import 'package:chat_app/widgets/message.dart';
import 'package:chat_app/widgets/newmessages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class chatscreen extends StatefulWidget {
  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((mes) {
      if(mes.notification != null)
      {
        print(mes.notification!.body);
        print(mes.notification!.title);
      }
     });

     FirebaseMessaging.instance.subscribeToTopic('chat');


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
        actions: [
          DropdownButton(
            underline: Container(),
              icon: Icon(
                Icons.more_horiz,
                color: Colors.orange,
              ),
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app,color:Colors.black),
                      SizedBox(width: 8),
                      Text("logout"),
                    ],
                  ),
                  value: "logout",
                ),
              ],
              onChanged: (itemidentifer) {
                if (itemidentifer == "logout") FirebaseAuth.instance.signOut();
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: messages()),
            newmessage(),
          ],
        ),
      ) ,

    );
  }
}
