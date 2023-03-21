import 'dart:async';

import 'package:detect_blindness/homepage/home.dart';
import 'package:detect_blindness/login%20and%20signup/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';

class verifyemailpage extends StatefulWidget {
  const verifyemailpage({Key? key}) : super(key: key);

  @override
  State<verifyemailpage> createState() => _verifyemailpageState();
}

class _verifyemailpageState extends State<verifyemailpage> {
  bool isemailverified=false;
  Timer ?timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isemailverified= FirebaseAuth.instance.currentUser!.emailVerified;
    print("HEllo$isemailverified");
    if(!isemailverified)
      {
        verifyemail();
        timer= Timer.periodic(
         const  Duration(seconds :3),
            (_)=> checkemailverify(),

        );
      }
  }
  @override
  void dispose() {
    // TODO: implement dispose

    timer?.cancel();
    super.dispose();
  }
  Future checkemailverify()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isemailverified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isemailverified)
      timer?.cancel();
  }
  Future verifyemail()async{
   try {
     final user = FirebaseAuth.instance.currentUser;
     await user?.sendEmailVerification();
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
             content: Text(' Verification Email has been sent ')));
   }
   catch(e)
    {
      print(e.toString());
    }



  }

  @override
  Widget build(BuildContext context )=> isemailverified
  ? homepage():
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( begin: Alignment.topRight,
            //end: Alignment(0.3, 0),
            end:Alignment.bottomLeft,
            tileMode: TileMode.repeated, // repeats the gradient over page
            colors: [
              // Colors are easy thanks to Flutter's Colors class
              Color(0xFF8EC5FC),
              Color(0xFFE0C3FC),
              //Colors.red,
              //Colors.orange,
            ], )
        ),
  child:Scaffold(
    backgroundColor: Colors.transparent,
    body: SafeArea(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[ Text("A verification email has been sent to your account",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ))
            ]
        )

    )

  )
      );

}
