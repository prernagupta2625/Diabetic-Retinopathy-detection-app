import "package:flutter/material.dart";
import 'package:detect_blindness/login%20and%20signup/signup.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import "package:firebase_auth/firebase_auth.dart";

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    Future login() async {
      showDialog(context: context,
          builder: (context)=>Center(child: CircularProgressIndicator()));
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim(),
        );
      }
      on FirebaseAuthException catch(e)
      {
        print(e);
      }
      //navigatorKey.currentState!.popUntil((route) => route.isFirst);
      Navigator.of(context).pop();
    }

    return Container(
      padding:EdgeInsets.all(20),
        decoration :BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            //end: Alignment(0.3, 0),
            end:Alignment.bottomLeft,
            tileMode: TileMode.repeated, // repeats the gradient over page
            colors: [
              // Colors are easy thanks to Flutter's Colors class
              Color(0xFF8EC5FC),
             Color(0xFFE0C3FC),
              //Colors.red,
              //Colors.orange,
            ],
          ),
        ),
        child:Scaffold(
        backgroundColor: Colors.transparent,
      body:
      Center(
    child:SingleChildScrollView(
        child:
        Column(children:[Row( crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[Text(" Welcome ! ",
              style: TextStyle(
                fontSize: 38,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),)]),
          SizedBox(
            height:25,
          ),
          Container(
          margin: const EdgeInsets.all(6.5),
          padding:EdgeInsets.all(15),
          width: width,
          decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
    Radius.circular(10),
    ),
    boxShadow: [
    BoxShadow(
    color: Color(0xffDDDDDD),
    blurRadius: 6.0,
    spreadRadius: 2.0,
    offset: Offset(0.0, 0.0),
    )
    ],

        ),
             child: Center( child: Column(
            children: [
             Container(height:100,
               width:100,
               child:Image.asset("assets/images/eyeedit.png",),
             ),
              SizedBox(height: 15),
              TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: "xyz@gmail.com",
                    labelText: "E-mail",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black54,
                    ),
                    /*border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xffD24C4A),
                          width: 3,
                        )
                    ),*/
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 3,
                        )
                    ),
                  )
              ),
              SizedBox(height: 20,),
              TextField(
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "*******",
                   /* border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xffD24C4A),
                        )
                    ),*/
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,

                          width: 1,
                        )
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    )
                ),
              ),

              SizedBox(height: height*0.075,),
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            width: width * 0.33,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  //Color(0xFF0D47A1),
                                  //Color(0xFF1976D2),
                                  //Color(0xFF42A5F5),
                                  Color(0xFF8EC5FC),
                                  Color(0xFFE0C3FC),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(10.0),
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                                login();
                            },
                            child: Center(child: const Text('Log-in',
                              textAlign: TextAlign.center,),)
                        )
                      ]
                  ))
              ,
              SizedBox(height:10)
          ],

        ),

      ),

    ),
          SizedBox(height: height * 0.075,),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => signuppage()));
            },
            child: Text.rich(TextSpan(
                text: 'Don\'t have an account ? ',
                children: [
                  TextSpan(
                    text: 'Signup',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 20, //Color(0xffEE7B23)
                    ),
                  ),
                ]
            ),
            ),
          )
        ],
    )
    )
      )
    )
    );

  }
}
