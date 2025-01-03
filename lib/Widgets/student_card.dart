import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_quiz_frontend/BackendAPIs/StudentAPIs.dart';
import 'package:online_quiz_frontend/model/marksmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:provider/provider.dart';
import '../model/quizmodel.dart';
import '../screens/faculty/question_screen.dart';
import '../screens/student/quiz_screen.dart';
import '../screens/student/view_score.dart';
import '../utils/utils.dart';

class StudentCard extends StatefulWidget {
  // final Quiz quiz;
  final Marks marks;

  const StudentCard({
    super.key,
    // required this.quiz,
    required this.marks,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  String name ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
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
              onTap:(){widget.marks.status! ? Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen( quiz: widget.marks.quiz!,))):null;},

              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ListTile(
                  title: Text(
                    widget.marks.quiz!.quizTitle.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  subtitle: Text(
                    widget.marks.quiz!.subName.toString(),
                    style: TextStyle(fontSize: 15,color: Colors.white),
                  ),
                  trailing:widget.marks.status==false?ElevatedButton(
                    onPressed: (){
                      var pro = Provider.of<FacultyProvider>(context,listen: false);
                      pro.getAllquestionsListOfPerticularQuizId(widget.marks.quiz!.quizId);
                      print(widget.marks.toJson());
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentQuiz(quiz: widget.marks.quiz!)));},
                    child: Text('Join Quiz'),
                  ):ElevatedButton(
                    onPressed: ()async{
                      showMarksDialog(context,widget.marks.marksObtained.toString(),widget.marks.quiz!);},
                    child: Text('View Score'),

                  )

                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 15,color: Colors.white),
                      ),
                    ),
                  ),
                )
              ]),
            )),
      ),
    );
  }

  void getdata() async{
    var facultyPro = Provider.of<FacultyProvider>(context,listen: false);
    facultyPro.clear();
    facultyPro.getAllquestionsListOfPerticularQuizId(widget.marks.quiz!.quizId);
    name = await StudentAPIs().getFacultyNameUsingQuizModel(widget.marks.faculty!.uid);
  }
}
