import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/provider/provider.dart';
import 'package:online_quiz_frontend/provider/studentProvider.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:online_quiz_frontend/screens/HomeScreen.dart';
import 'package:online_quiz_frontend/screens/faculty/facultyScreen.dart';
import 'package:online_quiz_frontend/screens/sign_up_screen.dart';
import 'package:online_quiz_frontend/screens/student/studentscreen.dart';
import 'package:online_quiz_frontend/test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_screen.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AppState()),
        ChangeNotifierProvider(create: (_)=>UserInformation()),
        ChangeNotifierProvider(create: (_)=>FacultyProvider()),
        ChangeNotifierProvider(create: (_)=>StudentProvider()),
      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Online Quiz",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        // colorScheme: ColorScheme.dark(),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // Set your global border color here
          ),
          hintStyle: TextStyle(
            color: Colors.black
          )
        ),

      ),
      home: Stream()
    );
  }
}

class Stream extends StatefulWidget {
  const Stream({super.key});

  @override
  State<Stream> createState() => _StreamState();
}

class _StreamState extends State<Stream> {
  @override
  void initState() {
    // TODO: implement initState
    getKey();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Image.asset('assets/ic_launcher.png'),
      child: CircularProgressIndicator(color: Colors.black,),
    );
  }

  void getKey() async{
   var pro =   Provider.of<UserInformation>(context,listen: false);
   var res = await pro.getUserData();
   // if(res=="success"){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CheackUserStream()));
   // }
   // Fluttertoast.showToast(msg: res,timeInSecForIosWeb: 3);

  }
}

