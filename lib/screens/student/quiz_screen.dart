import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/StudentAPIs.dart';
import 'package:online_quiz_frontend/model/marksmodel.dart';
import 'package:online_quiz_frontend/model/questionmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/provider/studentProvider.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:provider/provider.dart';
import '../../Widgets/quiz_widget.dart';
import '../../resources/fetchquestions.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart'as model;

class StudentQuiz extends StatefulWidget {

  final model.Quiz quiz;


  const StudentQuiz({super.key, required this.quiz,});

  @override
  State<StudentQuiz> createState() => _StudentQuizState();
}
class _StudentQuizState extends State<StudentQuiz> {
  // Future<void> getmarks() async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('quiz')
  //       .doc(widget.snap['quizuid'])
  //       .collection('students')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   marks = snapshot['marks'];
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // getmarks();
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   marks = 0;
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body:   Consumer<FacultyProvider>(
        builder: (context,pro,child)=>
         ListView.builder(
            itemCount: pro.questions.length+1,
            itemBuilder: (context, index) {
              return index == pro.questions.length
                  ? Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 30,
                    vertical: width > webScreenSize ? 15 : 10,
                  ),
                  width: double.infinity,
                  child: FilledButton(onPressed:()=>_submit(pro.questions.length.toString()), child: Text('Submit'))
              )
                  : QuizWidget(
                index: index + 1,
                quizuid: widget.quiz.quizId, question: pro.questions[index],
              );
            }),
      )
    );
  }



  void _submit(length) async{
   var pro = Provider.of<StudentProvider>(context,listen: false);
   var userPro = Provider.of<UserInformation>(context,listen: false);
   int marks = pro.checkAns();
   Marks m = Marks(marksId: '', quizId: widget.quiz.quizId, studentId: userPro.userId,marksObtained: marks,status: true);
   String res = await StudentAPIs.updateMarks(m);
   print("this is marks $marks");

   if(res == 'success'){
     pro.clear();
     pro.clearQuizAndMarks();
     pro.getMarksByStudentId(userPro.userId);
     shosnacbar(context, "Submitted");
     Navigator.pop(context);
   }
   shosnacbar(context, res);
  }
}
// SizedBox(height: 10,),
// FilledButton(onPressed: (){}, child: Text('Submit'))
