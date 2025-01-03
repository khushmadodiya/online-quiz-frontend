import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custom_floatingbutton.dart';
import '../../Widgets/question_card.dart';
import '../../utils/utils.dart';
import 'add_questions.dart';

class QuestionScreen extends StatefulWidget {
  final Quiz quiz;
  const QuestionScreen({super.key, required this.quiz});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getqustion();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.quiz.quizTitle),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0), // Adjust the height as needed
            child: Divider(
              thickness: 1,
              color: Colors.black54,
            ),
          )),
      floatingActionButton: CustomFloatingbutton(ontap: (){ Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddQuestion(
                quiz: widget.quiz,
              )));}),
      body: Consumer<FacultyProvider>(
               builder: (context,facultyPro,child)=>
               ListView.builder(
                itemCount: facultyPro.questions.length,
                itemBuilder: (context, index) {
                  return QuestionCard(
                    question: facultyPro.questions[index],
                    index: index+1,
                  );
                },
              ),
            )
    );
  }

  void getqustion() async{
    var facultyPro = Provider.of<FacultyProvider>(context,listen: false);
    facultyPro.clear();
    facultyPro.getAllquestionsListOfPerticularQuizId(widget.quiz.quizId);
  }
}
