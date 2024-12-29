import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
import 'package:online_quiz_frontend/model/questionmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:provider/provider.dart';
import '../resources/firestore_methso.dart';
import '../screens/faculty/edit_question_screen.dart';
import '../utils/utils.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final index;
  const QuestionCard({super.key, required this.question, this.index,});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<FacultyProvider>(
      builder:(context,pro,child)=>
       Container(
          margin: EdgeInsets.symmetric(
            horizontal: width > webScreenSize ? width * 0.3 : 30,
            vertical: width > webScreenSize ? 15 : 10,
          ),

          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],

            // image: DecorationImage(image: AssetImage("assets/questionsCard.jpg"),fit: BoxFit.cover)
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
              leading: Text(
                '${widget.index.toString()})',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              title: SelectableText(
                widget.question.questionName.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                       children: [
                         SimpleDialogOption(
                           child: Center(child: Text('Edit',style: TextStyle(fontSize: 20),)),
                           onPressed: () {
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                     EditQuestionScreen(question: widget.question)));
                           }
                         ),
                         SizedBox(height: 10,),
                         SimpleDialogOption(
                             child: Center(child: Text('Delete',style: TextStyle(fontSize: 20),)),
                             onPressed: () async{
                               showDialog(
                                   context: context,
                                   builder: (context) =>
                                       AlertDialog(title: Text('Are you sure'), actions: [
                                         TextButton(
                                             onPressed: ()async {
                                               Navigator.pop(context);
                                               Navigator.pop(context);

                                             },
                                             child: Text('No')),
                                         TextButton(
                                             onPressed: ()async {
                                              var res =  await FacultyAPIs.deleteQuestion(widget.question.questionId);
                                              print(res);
                                               pro.getAllquestionsListOfPerticularQuizId(widget.question.quizId);
                                               Navigator.pop(context);
                                               Navigator.pop(context);
                                               // QuerySnapshot  snap = await FirebaseFirestore.instance
                                               //     .collection('quiz').where('facultyuid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
                                               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuestionScreen(snap: snap)));
                                               // shosnacbar(context, res);
                                             },
                                             child: Text('Yes')),

                                       ]));

                             }
                         ),
                       ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
            ListTile(
              leading: Text(
                'I)',
                style: TextStyle(fontSize: 17),
              ),
              title: SelectableText(
                widget.question.option1.toString(),
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              leading: Text(
                'II)',
                style: TextStyle(fontSize: 17),
              ),
              title: SelectableText(
                widget.question.option2.toString(),
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              leading: Text(
                'III)',
                style: TextStyle(fontSize: 17),
              ),
              title: SelectableText(
                widget.question.option3.toString(),
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              leading: Text(
                'IV)',
                style: TextStyle(fontSize: 17),
              ),
              title: SelectableText(
                widget.question.option4.toString(),
                style: TextStyle(fontSize: 17),
              ),
              // trailing: Text("ans = ${widget.snap['ans']}",style: TextStyle(fontSize: 17),),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ans = ${widget.question.ans}",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              alignment: Alignment.bottomCenter,
            )
          ])),
    );
  }
}
