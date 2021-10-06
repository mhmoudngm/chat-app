import 'dart:io';
import 'package:chat_app/widgets/authform.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class authscreen extends StatefulWidget {
  @override
  State<authscreen> createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  bool isloading = false;
  void submitauthform(String email, String password, String username,File image,
      bool islogin, BuildContext ctx) async {
    try {
      setState(() {
        isloading = true;
      });
      if (islogin) {
        UserCredential authresult =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        UserCredential authresult =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance.ref().child("userimage").child(authresult.user!.uid + ".jpg");
        await ref.putFile(image);
        var url = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection("users").doc(authresult.user!.uid).set({
          'username': username,
          'password': password,
          'imageurl': url,
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = "error";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ));
      setState(() {
        isloading = false;
      });
    } catch (e) {
      setState(() {
        isloading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: authform(submitauthform,isloading),
    );
  }
}
