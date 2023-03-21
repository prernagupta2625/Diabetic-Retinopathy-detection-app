import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detect_blindness/infopage.dart';
import "package:flutter/material.dart";
import"package:detect_blindness/homepage/output_page.dart";
import"package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/services.dart';
//import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import "package:firebase_storage/firebase_storage.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:intl/intl.dart';
import 'package:tflite/tflite.dart';
import"package:detect_blindness/infopage.dart";
import"package:detect_blindness/faqs.dart";
import"package:detect_blindness/profile/profilepage.dart";

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  File? ImageFile;
  String ?username="";
  String? currentdate;
  final ImagePicker picker =new ImagePicker();
  final DocumentReference med = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.email);
  bool imageselect=false;
  late List _results;
  late File? _image;
  var downloadUrl;
  var snapshot;
  Future loadModel()
  async {
    Tflite.close();
    String res;
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    try {
      res = (await Tflite.loadModel(model: "assets/model_lite(1).tflite",
          labels: "assets/images/labels.txt"))!;
      print("Models loading status%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%: $res");
    }
    on PlatformException {
      print('Failed to load model.');
    }
  }
  Future imageclassification()
  async {
    print("oooooooooooooooooooooooooooooooooooooo");

    final List? recognitions = await Tflite.runModelOnImage(

      path: ImageFile!.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("llllllllllllllllllllllllllllllllllllllllllllllllllllllll");
    setState(() {
      _results = recognitions!;
      _image = ImageFile;
      imageselect = true;
    });
  }
    Future getdata()async{
      await med.get().then((snapshot) =>
      username=snapshot['Name']);
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentdate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  getdata();
  loadModel();
  }
  Future uploaddata()async{
    await med.collection("Medical_History").add({
      "Profile_Link": downloadUrl,
    });

  }

  void takephoto(ImageSource source)async
  {
    final pickedFile=await picker.getImage(
      source: source,
    );
    setState(() {

      ImageFile=File(pickedFile!.path);
    });

  }
  void processimage()
  {
    if(ImageFile!=null)
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>output_page()));
      }

  }

  Future _create ()async {
    //showDialog(context: context,
        //builder: (context) => Center(child: CircularProgressIndicator()));
    final _firebaseStorage = FirebaseStorage.instance;
    if (ImageFile != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .putFile(File(ImageFile!.path));

      downloadUrl = await snapshot.ref.getDownloadURL();

      uploaddata();
    }

  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    Widget bottomsheet() {
      return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child : Column(
            children : [
              Text (" Choose Your Scan",
                style : const TextStyle(
                  fontSize: 15,
                ),),
              SizedBox(
                height :10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon : Icon(Icons.camera),
                      onPressed : (){
                        takephoto(ImageSource.camera);
                      },
                      label : Text("Camera"),
                    ),
                    ElevatedButton.icon(
                      icon : Icon(Icons.image),
                      onPressed : (){
                        takephoto(ImageSource.gallery);
                      },
                      label : Text("Gallery"),
                    ),
                  ]//children
              )
            ]//children
        ),
      );
    }
    return Container(

    /*decoration :BoxDecoration(
    gradient: LinearGradient(
    // Where the linear gradient begins and ends
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    tileMode: TileMode.repeated, // repeats the gradient over page
    colors: [
    // Colors are easy thanks to Flutter's Colors class
     Color(0xFF8EC5FC),
     Color(0xFFE0C3FC),
    //Colors.red,
    //Colors.orange,
    ],
    ),
    ),*/
        child:Scaffold(
          backgroundColor: Colors.white,
          appBar:/* NewGradientAppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size:44,
                  ),

                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            gradient:LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.repeated, // repeats the gradient over page
              colors: [
                // Colors are easy thanks to Flutter's Colors class
                Color(0xFF8EC5FC),
                Color(0xFFE0C3FC),
                //Colors.red,
                //Colors.orange,
              ],
            ),
          ),*/ AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size:44,
                  ),

                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            backgroundColor:Color(0xFF8EC5FC) ,

          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children:  <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient:LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
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
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Messages'),
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>ScheduleTab()));
                  }
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>profilepage()));

                    }
                ),

                ListTile(
                  leading: Icon(Icons.description_rounded),
                  title: Text('Diabetic Retinopathy')
                  ,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>FAQPage()));

                  } ),

                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign out'),
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),

        body: SingleChildScrollView(
          child:Container(
            padding:EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:10),
              Row( crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Text.rich(TextSpan(children:[TextSpan(
                        text: ' Start ',
                        style: TextStyle(
                          fontSize: 33,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = LinearGradient(
                              colors: <Color>[
                                Color(0xFF8EC5FC),
                                Color(0xFFE0C3FC),
                                //add more color here.
                              ],
                            ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))

                        ),
                    ),

                          TextSpan(
                            text: 'your eye ',
                            style: TextStyle(
                              color:Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,//Color(0xffEE7B23)
                            ),
                          ),
                          TextSpan(
                            text: 'Journey ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,//
                              foreground: Paint()..shader = LinearGradient(
                                colors: <Color>[
                                  Color(0xFF8EC5FC),
                                  Color(0xFFE0C3FC),
                                  //add more color here.
                                ],
                              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)),
                              fontSize: 18, //Color(0xffEE7B23)
                            ),
                          ),
                          TextSpan(
                            text: 'with us ',
                            style: TextStyle(
                              color:Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,///Color(0xffEE7B23)
                            ),
                          ),
                          TextSpan(
                            text: '!! ',
                            style: TextStyle(
                              foreground: Paint()..shader = LinearGradient(
                                colors: <Color>[
                                  Color(0xFF8EC5FC),
                                  Color(0xFFE0C3FC),
                                  //add more color here.
                                ],
                              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,//Color(0xffEE7B23)
                            ),
                          ),
                        ]
                    ),
                    ),
                  ]),
              SizedBox(
                height:15,
              )
,
              Container(
                margin: const EdgeInsets.all(6.5),
                height:340,
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
                child: Column(
                  children: [
                    ImageFile==null?
                    photo():image(),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height : 15,
              ),
            Container(
              margin: const EdgeInsets.all(6.5),
              //height:40,
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
              child:Column(
                children: [
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
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder)=> bottomsheet()),
                                  );
                                },
                                child: Center(child: const Text('Upload Scan',
                                  textAlign: TextAlign.center,),)
                            )
                          ]
                      )),
                  SizedBox(
                    height : 20,
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
                                 processimage();
                                  _create();
                                },
                                child: Center(child: const Text('Test Scan',
                                  textAlign: TextAlign.center,),)
                            )
                          ]
                      )),
                ],
              ),
            )


            ],
          ),

        )
        )
    )
    );



  }
  Widget photo(){
    return Container( width: MediaQuery.of(context).size.width,
        height:300,

        decoration : BoxDecoration(
          border : Border.all(
            color : Colors.grey,
          ),
          borderRadius : BorderRadius.circular(15),
        ),
         child: Icon( Icons.remove_red_eye,
          color:Colors.grey,
        )

    );

  }//widget
  Widget image(){
    return Container( width: MediaQuery.of(context).size.width,
        height :150,

        decoration : BoxDecoration(
          border : Border.all(
            color : Colors.grey,
          ),
          borderRadius : BorderRadius.circular(15),
        ),
        child : Center(
          child : Image.file(ImageFile!),
        )
    );

  }//widget


}
