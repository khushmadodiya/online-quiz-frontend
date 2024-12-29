import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/StudentAPIs.dart';
import 'model/usermodel.dart'as model;
class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StudentAPIs().fetchStudents();
    model.User user= model.User(username: "dipu", uid: "325", photoUrl: '', email: 'dipu@gmail.com', usertype: '');
    // StudentAPIs().createStudent(user);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("hello"),
    );
  }
}
