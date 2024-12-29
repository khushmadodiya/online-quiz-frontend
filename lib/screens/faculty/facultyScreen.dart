
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/create_quiz_dialoge.dart';
import '../../Widgets/custom_floatingbutton.dart';
import '../../Widgets/facultycard.dart';
import '../../main.dart';
import '../../resources/auth_methods.dart';

import '../HomeScreen.dart';
import '../profile_screen.dart';



class FacultyScreen extends StatefulWidget {

  const FacultyScreen({super.key,});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {

  // String url ='https://www.google.com/imgres?q=person%20image&imgurl=https%3A%2F%2Ft3.ftcdn.net%2Fjpg%2F01%2F65%2F63%2F94%2F360_F_165639425_kRh61s497pV7IOPAjwjme1btB8ICkV0L.jpg&imgrefurl=https%3A%2F%2Fstock.adobe.com%2Fsearch%3Fk%3Dperson&docid=u8MkgSDI8RpPkM&tbnid=mor2oqglmbZcuM&vet=12ahUKEwjSvd3C0NiFAxUGlK8BHQqwDoQQM3oECH4QAA..i&w=360&h=360&hcb=2&ved=2ahUKEwjSvd3C0NiFAxUGlK8BHQqwDoQQM3oECH4QAA';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInformation>(
      builder: (context,pro,child)=>
       Scaffold(
        appBar: AppBar(

          title: Text('Online Quiz',style: TextStyle(fontWeight: FontWeight.bold),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0), // Adjust the height as needed
            child: Divider(
              thickness: 1,
              color: Colors.black54,
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
              },
              child:  Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(pro.photoUrl)
                  // child: Container(),
                ),

              ),

            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        children: [
                          SimpleDialogOption(
                              child: Center(
                                  child: Text(
                                'Log out',
                                style: TextStyle(fontSize: 20),
                              )),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: Text('Are you sure'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  },
                                                  child: Text('No')),
                                              TextButton(
                                                  onPressed: () async {
                                                    String res =
                                                        await AuthMethod()
                                                            .signOut();
                                                    if (res == 'success') {
                                                      var pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      pref.setString('key', '');
                                                      pro.clear();
                                                      Navigator.popUntil(context, (route) => false);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      HomeScreen()));
                                                    }
                                                  },
                                                  child: Text('Yes')),
                                            ]));
                              }),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.settings))
          ],
        ),
        floatingActionButton:CustomFloatingbutton(ontap:(){ showCreateQuizDialog(context);}),
        body: Consumer<UserInformation>(
          builder: (context,pro,child)=>
           Consumer<FacultyProvider>(builder: (context,facultyPro,child){
              return ListView.builder(
                itemCount: facultyPro.quizzes.length,
                itemBuilder: (context, index) {
                  Quiz quiz = facultyPro.quizzes[index];
                  return FacultyCard(quiz: quiz,);
                },
              );
            },
          ),
        ),
       )
    );
  }

  void getdata()async {
    var pro = Provider.of<FacultyProvider>(context,listen: false);
    var userinfo = Provider.of<UserInformation>(context,listen: false);
    pro.getAllquizzesList(userinfo.userId);
  }

}
// onPressed: ()async{
// await AuthMethod().signOut();
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
// },
