import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/provider/studentProvider.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:online_quiz_frontend/screens/student/quiz_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/custom_floatingbutton.dart';
import '../../Widgets/student_card.dart';
import '../../main.dart';
import '../../model/marksmodel.dart';
import '../../provider/provider.dart';
import '../../resources/auth_methods.dart';
import '../HomeScreen.dart';
import '../login_screen.dart';
import '../offline quizes/guess_name.dart';
import '../offline quizes/spot_the_diffrence.dart';
import '../profile_screen.dart';
import '../sign_up_screen.dart';
import 'joinquiz.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart'as model;

class StudentScreen extends StatefulWidget {

  const StudentScreen({super.key,});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  String quizid='';
  bool flag=false;
  String url ='data:image/png;base64,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';
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
          leading: IconButton(
            onPressed: () {
        showDialog(
          useRootNavigator: false,
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: [
                SimpleDialogOption(
                    child: Center(
                      child: Container(
                        width: double.infinity,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple[100],
                        ),
                        height: 40,
                        child: Center(
                          child: Text(
                            'Spot the difference',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Spot()));
                    }),
                SimpleDialogOption(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple[100],
                      ),
                      child: Center(
                        child: Text(
                          'Guess the name',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      height: 40,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => Guess()));
                    }),
              ],
            );
          }
          );
            },
            icon: FaIcon(FontAwesomeIcons.bars),
          ),
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
                                                  Navigator.popUntil(context, (route) => false);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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
        floatingActionButton: CustomFloatingbutton(ontap: (){
          ShowJoinQuizDialog(context);
        }),
        body: Consumer<StudentProvider>(
           builder: (context ,studentPro,child)=>
               ListView.builder(
              itemCount: studentPro.marksList.length,
              itemBuilder: (context, index) {
                return studentPro.marksList.isEmpty?Container(
                ):StudentCard(
                  // quiz:studentPro.studentQuizzes[index],
                  marks:studentPro.marksList[index]
                );
              },

        ),
        )
       )
    );
  }

  void getdata() async{

   WidgetsBinding.instance.addPostFrameCallback((_){
     var pro =  Provider.of<StudentProvider>(context,listen: false);
     var userPro =  Provider.of<UserInformation>(context,listen: false);
     pro.getMarksByStudentId(userPro.userId);
   });

  }
}