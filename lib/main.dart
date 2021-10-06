import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.grey[200],

        primarySwatch: Colors.pink,
        accentColor: Colors.deepPurple,
        backgroundColor: Colors.pink,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), //معناها القيمه الراجعه بعد العمليه بها بيانات ال هى التوكن والاى دى بمعنى ان فيه تسجيل دخول وهذه البيانات بتتشال فى حاله تسجيل الخروج
        builder: (ctx,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return splashscreen();
            }
          if(snapshot.hasData)
            {
              return chatscreen();
            }
          else
            {
              return authscreen();
            }
        },
      ) ,
    );
  }
}



