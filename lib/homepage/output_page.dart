import 'dart:math';

import "package:flutter/material.dart";
import 'package:detect_blindness/login%20and%20signup/signup.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import "package:firebase_auth/firebase_auth.dart";
class output_page  extends StatefulWidget {
  output_page ({Key? key}) : super(key: key) {
    // TODO: implement output_page

  }

  @override
  State<output_page> createState() => _State();

}

class _State extends State<output_page> {
  String? labelText;
  String? prediction;

  @override
  void initState() {
    // TODO: implement initState

    int predictionValue = Random().nextInt(5);
    setState(() {
      switch (predictionValue) {
        case 0:
          labelText = 'Not Serious';
          break;
        case 1:
          labelText = 'Mild';
          break;
        case 2:
          labelText = 'Moderate';
          break;
        case 3:
          labelText = 'Serious';
          break;
        case 4:
          labelText = 'Very Serious';
          break;
      }
    });

  }




  @override
  Widget build(BuildContext context)  {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;{
      return Container(
        width: width,

          padding:EdgeInsets.all(10),
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
                      Expanded(child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                            Container(

                          padding: EdgeInsets.all(8),
                              width: width,
                              child :Text(" The Severity of the uploaded retinal scan is : ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,

                            ),)),

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
                              Container(
                                width:width,
                                child: Text( "$labelText",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,

                                  ),),
                              ),


                              SizedBox(height:10)
                            ],

                          ),

                          ),

                        ),


                      ],
                      ))
                  )
              )
          )
      );
    }

  }
}
