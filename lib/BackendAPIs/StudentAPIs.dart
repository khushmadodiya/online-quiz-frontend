import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:online_quiz_frontend/model/marksmodel.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:online_quiz_frontend/model/usermodel.dart'as model;

import '../globle.dart';

class StudentAPIs{



  void fetchStudents() async {

    final response = await http.get(Uri.parse('$url/student'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<model.User>list= jsonResponse.map((student) => model.User.fromJson(student)).toList();
      for(model.User i in list){
        print(i.uid);
        print(i.username);
        print(i.email);
        print(i.photoUrl);
      }
    } else {

      throw Exception('Failed to load students');
    }
  }

  Future createUser(model.User user,String type)async{

     try{
       final response = await http.post(
         Uri.parse("$url/$type"),
         headers: {
           "Content-Type": "application/json",
         },
         body: jsonEncode(user.toJson()),
       );

       print("Status Code${response.statusCode}");
       if(response.statusCode == 200){
         print("Student Created Successfully");
         return 'success';
       }
       else{
         return "Failed to Create User";
       }
     }catch(e){
       return "Check you internet connection";
     }

  }

  static Future joinQuiz(Marks marks)async{
    try{
      print(marks.toJson());
     var res =  await http.post(
        Uri.parse("$url/marks"),
        headers: {
          "Content-Type":"application/json"
        },
        body: jsonEncode(marks.toJson())
      );
     print("this is khush ${res.statusCode}");
     if(res.statusCode == 200){
       if(res.body=="success"){
         return "success";
       }
       else{
         return "Quiz not found";
       }
     }
     else{
       return "Failed to Join Quiz";
     }

    }catch(e){
      return "Check you internet connection";
    }

  }
  static Future fetchQuizzes(String studentId) async {
    try {
      var res = await http.get(Uri.parse("$url/student/quiz/$studentId"));
      print(res.statusCode);
      print("statuscode");
      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        List<Quiz> list = [];
        // print(jsonResponse);
        for (dynamic item in jsonResponse) {
          list.add(Quiz.fromJson(item));
        }
        for(Quiz i in list){
          print(i.toJson());
        }
        return list;
      } else {
        throw Exception('Failed to fetch quizzes');
      }
    } catch (e) {
      return [];
    }
  }
  
  static Future updateMarks(Marks marks)async{
   try{
     var res = await http.post(
         Uri.parse('$url/student/quiz/submit'),
         headers: {
           "Content-Type":"application/json"
         },
         body: jsonEncode(marks.toJson())
     );
     if(res.statusCode ==200){
       return "success";
     }
     else{
       return "Failed to submit Quiz";
     }
   }catch(e){
     return "Failed to submit Quiz";
   }
  }

  static Future getAllMarksWithStudentId(String studentId) async {
    List<Marks> marks = [];
    try {

      var res = await http.get(
        Uri.parse("$url/marks/$studentId"),
        headers: {
          "Content-Type": "application/json",
        },
      );


      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);

          for (Map<String, dynamic> item in jsonResponse) {
            marks.add(Marks.fromJson(item));
          }
          return marks; // Successfully fetched and parsed
        }
      return [];
    } catch (e) {
      return [];
    }
  }


  Future getFacultyNameUsingQuizModel(String facultyId)async{
  var res =   await http.get(Uri.parse("$url/student/faculty/$facultyId"));

   if(res.statusCode==200){
     String facultyName = res.body.toString();
     print("this is facultyName${facultyName}");
     return facultyName;
   }
  }

  Future getNoOfQuestionByQuizId(String quizId)async{
  var res =   await http.get(Uri.parse("$url/student/question/count/$quizId"));
  print("res statuscode");
  print(res.statusCode);
   if(res.statusCode==200){
     String no = res.body.toString();
     print("no of question$no");
     return no;
   }
  }
}