import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:online_quiz_frontend/screens/HomeScreen.dart';
import 'package:online_quiz_frontend/screens/faculty/facultyScreen.dart';
import 'package:online_quiz_frontend/screens/student/studentscreen.dart';
import 'package:provider/provider.dart';

class CheackUserStream extends StatefulWidget {
  const CheackUserStream({super.key});

  @override
  State<CheackUserStream> createState() => _CheackUserStreamState();
}

class _CheackUserStreamState extends State<CheackUserStream> {

  @override
  Widget build(BuildContext context) {
    return  Consumer<UserInformation>(
      builder: (context,pro,child)=>
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if(snapshot.connectionState==ConnectionState.active){

                if(snapshot.hasData){

                  if(pro.userType=='Student'){
                    return StudentScreen();
                  }
                  else if(pro.userType=='Faculty'){
                    return FacultyScreen();
                  }
                }
                else if(snapshot.hasError){
                  return Center(child: Text('some error occur'),);
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Homesplesh();
            },
          ),
    );
  }

}
