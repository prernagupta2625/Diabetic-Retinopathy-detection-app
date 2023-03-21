import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import"package:firebase_auth/firebase_auth.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:detect_blindness/login%20and%20signup/login.dart";
class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}
final GlobalKey<FormState> _key = GlobalKey<FormState>();
class _signuppageState extends State<signuppage> {
  TextEditingController _emailidcontroller=new TextEditingController();
  TextEditingController _passwordcontroller=new TextEditingController();
  TextEditingController _confirmpasswordcontroller=new TextEditingController();
  TextEditingController _nameofuser=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CollectionReference usersinstance= FirebaseFirestore.instance.collection('Users');
    Future _create ()async{
      final id=usersinstance.doc(_emailidcontroller.value.text);
      final json={
        "Name":  _nameofuser.value.text,
        "Email" : _emailidcontroller.value.text,
        "Password" : _confirmpasswordcontroller.value.text,
        "Phone_No":"**********",
        "Profile_Link":"https://firebasestorage.googleapis.com/v0/b/animal-app-b6ba8.appspot.com/o/blank-profile-picture-g0989b9ec3_1280.png?alt=media&token=5154108d-0774-4d90-9fe7-3d9d443f2146"
      };
      await id.set(json);
      Navigator.of(context).pop();
    }

    Future SignUp() async {
      //showDialog(context: context,
         // builder: (context) => Center(child: CircularProgressIndicator()));
      if (_passwordcontroller.value.text ==
          _confirmpasswordcontroller.value.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailidcontroller.value.text.trim(),
              password: _passwordcontroller.value.text.trim());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use'){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(' Account already exists with this e-mail')),
            );
            Navigator.of(context).pop();
          }
          else if (e.code == 'weak-password') {
            /* Fluttertoast.showToast(
                msg: "Password is too weak ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0
            );*/
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(' Password length should be 6 or greater ')),
            );
            Navigator.of(context).pop();
          }
        } catch (e) {
          print(e);
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Password and Confirm Password should be same')),
        );
        Navigator.of(context).pop();

      }
    _create();

    }



      double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Container(
      padding:EdgeInsets.all(30),
      decoration :BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
         // end: Alignment(0.3, 0),
          end:Alignment.bottomLeft,
          tileMode: TileMode.repeated, // repeats the gradient over page
          colors: [
            // Colors are easy thanks to Flutter's Colors class
            Color(0xFF8EC5FC),
             Color(0xFFE0C3FC),
           // Colors.red,
            //Colors.orange,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body:Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Row( crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children:[Text("Create Account",
                      style: TextStyle(
                      fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                    ),)]),
                    SizedBox(
                      height:25,
                    )
                    ,
                    Container(
                      margin: const EdgeInsets.all(6.5),
                      padding:EdgeInsets.all(15),
                      width: width,
                      decoration: const BoxDecoration(
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
                      child:Form( key: _key,
                     child: Column(
                        children: [
                          userkind(),
                          SizedBox(height: 10,),
                          emailfield(),
                          SizedBox(height: 10,),
                          passwordwidget(),
                          SizedBox(height: 10,),
                          confirmpasswordwidget(),
                          SizedBox(
                            height : 25,
                          ),
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
                                          if (_key.currentState!.validate()) {  SignUp();}
                                        },
                                        child: Center(child: const Text('Sign-up',
                                          textAlign: TextAlign.center,),)
                                    )
                                  ]
                              )),
                      SizedBox(
                      height : 20,
                    ),

                        ],
                      ),
                      ),
                    ),
                    SizedBox(
                      height:35,
                    ),

                    Row(
                        crossAxisAlignment:CrossAxisAlignment.center,
                        children:[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => loginpage()));
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account ? ',
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 20, //Color(0xffEE7B23)
                              ),
                            ),
                          ]
                      ),
                      ),
                    )]),
                  ],
              ),
                ),
              ),
            )
          ),
      );

  }
  Widget userkind(){

    return TextFormField(
      controller: _nameofuser,
      validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Enter your Name';
      }
      return null;
    },
      decoration: InputDecoration(
          labelText: "User",
          prefixIcon: Icon(
            Icons.person,
            color:  Colors.grey, //Color(0xFFE0C3FC),

          ),
         /* border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color :Color(0xffD24C4A),
                width: 3,
              )
          ),*/
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color :Colors.blueAccent,
                width: 3,
              )
          )

      ),
    );
  }
  Widget emailfield()
  {
    return TextFormField(
     controller: _emailidcontroller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your Email';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "xyz@gmail.com",
          labelText: "E-mail",
          prefixIcon: Icon(
            Icons.person,
            color: Colors.grey,//Color(0xFFE0C3FC),
          ),
        /*  border: OutlineInputBorder(
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

            ),
          )

      ),);

  }
  Widget passwordwidget()
  {
    return TextFormField(
      controller: _passwordcontroller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Password';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "*******",
         /* border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xffD24C4A),
                width: 3,
              )

          ),*/
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color:Colors.blueAccent,

                width: 3,
              )
          ),
          prefixIcon: Icon(
            Icons.lock,
            color:Colors.grey,//Color(0xFFE0C3FC),
          )
      ),
    );
  }
  Widget confirmpasswordwidget()
  {
    return TextFormField(
      controller: _confirmpasswordcontroller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Confirm your password';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "*******",
        /*  border: OutlineInputBorder(
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
            color:Colors.grey,//Color(0xFFE0C3FC),
          )
      ),
    );
  }
}
