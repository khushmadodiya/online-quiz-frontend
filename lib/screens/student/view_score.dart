import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/StudentAPIs.dart';
import 'package:provider/provider.dart';

import '../../model/quizmodel.dart';
import '../../provider/facultyProvider.dart';

class ViewScoreDialog extends StatefulWidget {
  final marks;
  final max;
  const ViewScoreDialog({super.key, required this.marks,required this.max});

  @override
  State<ViewScoreDialog> createState() => _ViewScoreDialogState();
}

class _ViewScoreDialogState extends State<ViewScoreDialog> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: (){ FocusScope.of(context).unfocus();},
        child: Container(
            width: MediaQuery.of(context).size.width/2.5,
            height: MediaQuery.of(context).size.height/2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'You have completed the quiz.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Your score: ${widget.marks.toString()} out of ${widget.max.toString()} ', // Replace this with the actual score percentage
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
       
  }
}

void showMarksDialog(BuildContext context,String marks, Quiz quiz)async{
String no = await StudentAPIs().getNoOfQuestionByQuizId(quiz.quizId);
  showDialog(
    context: context,
    builder: (context) {
      return ViewScoreDialog(marks: marks, max: no,);
    },
  );
}
