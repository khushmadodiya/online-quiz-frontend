import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/student_marks_swidget.dart';
class StudnetsMarksScreen extends StatefulWidget {
  final snap;
  const StudnetsMarksScreen({super.key, required this.snap});
  @override
  State<StudnetsMarksScreen> createState() => _StudnetsMarksScreenState();
}

class _StudnetsMarksScreenState extends State<StudnetsMarksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Marks'),),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('quiz').doc(widget.snap['quizuid']).collection('students').snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){

                return StudentMarksWidget(snap: snapshot.data!.docs[index].data(),index: index+1,);
              });
        },
      ),
    );
  }
}