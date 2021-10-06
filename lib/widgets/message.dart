

import 'package:chat_app/widgets/messagebubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("chat").orderBy(
          "createdat", descending: true).snapshots(),
      builder: (ctx, snapshot){

          //  if (snapshot.connectionState == ConnectionState.waiting) {
        //  return CircularProgressIndicator();
        //}
        final List ngm=[];
        final docs = snapshot.hasData? (snapshot.data as QuerySnapshot).docs:ngm;
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index)=>messagebubbles(
              docs[index]["text"],
              docs[index]["username"],
              docs[index]["userimage"] ,
              docs[index]["userid"] == user!.uid ,
              key: ValueKey(docs[index].id),
            ));
      },
    );
  }
}
