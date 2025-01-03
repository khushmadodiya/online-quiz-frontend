import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
import 'package:online_quiz_frontend/Widgets/student_marks_swidget.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:provider/provider.dart';
import '../model/marksmodel.dart';
import '../resources/firestore_methso.dart';
import '../screens/faculty/marks_screen.dart';
import '../screens/faculty/question_screen.dart';
import '../utils/utils.dart';

class FacultyCard extends StatefulWidget {
  final Quiz quiz;
  const FacultyCard({
    super.key,
    required this.quiz,
  });

  @override
  State<FacultyCard> createState() => _FacultyCardState();
}

class _FacultyCardState extends State<FacultyCard> {


  void _copyToClipboard() {
    Clipboard.setData(
        ClipboardData(text:widget.quiz.quizId.toString()));
    Navigator.pop(context);
    shosnacbar(context, 'Text copied to clipboard');
  }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<FacultyProvider>(
      builder: (context,facultyPro,child)=>
     Consumer<UserInformation>(
        builder: (context,pro,child)=>
         Container(
            margin: EdgeInsets.symmetric(
              horizontal: width > webScreenSize ? width * 0.3 : 30,
              vertical: width > webScreenSize ? 15 : 10,
            ),
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(193, 174, 242, 100),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage("assets/quizCard.jpg"),
                fit: BoxFit.cover,
              ),
            ),

            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestionScreen(quiz: widget.quiz)));
              },
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ListTile(
                  title: Text(
                    widget.quiz.quizTitle.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  subtitle: Text(
                    widget.quiz.subName.toString(),
                    style: TextStyle(fontSize: 17,color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              children: [
                                SimpleDialogOption(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text('Share Quiz',style: TextStyle(fontSize: 15,color: Colors.white),),),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.deepPurple)),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: SelectableText(
                                                  widget.quiz.quizId.toString(),
                                                  style: TextStyle(fontSize: 15,color: Colors.white),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: _copyToClipboard,
                                            icon: Icon(Icons.copy,color: Colors.white,),
                                          ),
                                          IconButton(onPressed: (){
                                            // Share.share('Click here https://online-quiz-8566e.web.app/ and join throught this code ${ widget.snap['quizuid'].toString()}');
                                            Navigator.pop(context);
                                          }, icon: Icon(Icons.share,color: Colors.white,))
                                        ],
                                      ),
                                    ),
                                    onPressed: () {}),
                                SizedBox(
                                  height: 10,
                                ),
                                SimpleDialogOption(
                                    child: Container(
                                     padding: EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black),
                                      child: Center(child: Text('Delete Quiz', style: TextStyle(fontSize: 20,color: Colors.white),)),
                                    ),
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
                                                          String res = await FacultyAPIs.deleteQuiz(widget.quiz.quizId);
                                                          facultyPro.getAllquizzesList(pro.userId);
                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                          shosnacbar(context, res);
                                                        },
                                                        child: Text('Yes'))
                                                  ]));
                                    }),
                                SimpleDialogOption(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black
                                    ),
                                      child: Center(child: Text('Student Marks List',style: TextStyle(fontSize: 20,color: Colors.white),))),
                                  onPressed: ()async{
                                    print(widget.quiz.toJson());
                                    List<Marks> list  = await FacultyAPIs().getAllStudentWithQuizId(widget.quiz.quizId);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentMarksWidget(marksList: list,)));
                                  },

                                )
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.more_vert,color: Colors.white,),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        pro.userName,
                        style: TextStyle(fontSize: 17,color: Colors.white),
                      ),
                    ),
                  ),
                )
              ]),
            )),
      ),
    );
  }
}
