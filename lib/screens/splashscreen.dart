import 'package:flutter/material.dart';
class splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text("Loading....",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}
