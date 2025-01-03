// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
// import 'package:online_quiz_frontend/model/marksmodel.dart';
// import 'package:online_quiz_frontend/model/quizmodel.dart';
//
// import '../../Widgets/student_marks_swidget.dart';
// class StudnetsMarksScreen extends StatelessWidget {
//   final List<Marks> list;
//   const StudnetsMarksScreen({super.key, required this.list});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Marks'),),
//       body: ListView.builder(
//                 itemCount: list.length,
//                 itemBuilder: (context,index){
//
//                   return StudentMarksWidget(marks: list[index],index: index+1,);
//                 }),
//
//
//     );
//   }
//
// }