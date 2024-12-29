import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:online_quiz_frontend/model/questionmodel.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:provider/provider.dart';

import '../globle.dart';
class FacultyAPIs{

  static Future createQuiz(Quiz quiz,String uid)async{
   try{
     print(quiz.toJson());
     final response = await http.post(
       Uri.parse("$url/$uid/quiz"),
       headers: {
         "Content-Type": "application/json",
       },
       body: jsonEncode(quiz.toJson()),
     );
     if(response.statusCode == 200){
       print("Quiz created Successfully");
       return 'success';
     }
     else{
       print(response.statusCode);
       return "Quiz not created";
     }
   }
   catch(e){
     return e.toString();
   }
  }

  static Future fetchQuizStream(String facultyId) async {
    try {
      var res = await http.get(Uri.parse("$url/$facultyId/quiz/list"));
      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        List<Quiz> list = [];
        for (dynamic item in jsonResponse) {
          list.add(Quiz.fromJson(item));
        }

        return list;
      } else {
        throw Exception('Failed to fetch quizzes');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<String> deleteQuiz(String Id) async{
    try{
      var res = await http.get(Uri.parse("$url/quiz/$Id"));
      if(res.statusCode == 200){
        return "Deleted Successfully";
      }
      else{
        return "Failed to delete Quiz";;
      }
    }catch(e){
      print(e.toString());
      return "Failed to delete Quiz";
    }
  }

  static Future  createQuestion(Question question)async{
   try{
     var res =await http.post(
       Uri.parse("$url/question"),
       headers: {
         "Content-Type":"application/json"
       },
       body: jsonEncode(question.toJson()),
     );
     if(res.statusCode==200){
       return "success";
     }
     else{
       return "Failed to Create Question";
     }
   }catch(e){
     print(e.toString());
     return "Failed to Create Question";
   }
  }

  static Future  updateQuestion(Question question)async{
   try{
     var res =await http.post(
       Uri.parse("$url/question/update"),
       headers: {
         "Content-Type":"application/json"
       },
       body: jsonEncode(question.toJson()),
     );
     if(res.statusCode==200){
       return "success";
     }
     else{
       return "Failed to Update Question";
     }
   }catch(e){
     print(e.toString());
     return "Failed to Create Question";
   }
  }

  static Future  deleteQuestion(String questionId)async{
   try{
     var res =await http.get(
       Uri.parse("$url/question/delete/$questionId"),
     );
     if(res.statusCode==200){
       return "success";
     }
     else{
       return "Failed to Update Question";
     }
   }catch(e){
     print(e.toString());
     return "Failed to Create Question";
   }
  }

  static Future getAllquestionByQuizId(String quizId)async{
    print("this is quizId $quizId");
    try{
      var res = await http.get(Uri.parse('$url/question/$quizId'));
      if (res.statusCode == 200) {
        var jsonRes = jsonDecode(res.body);
        List<Question> questions = [];
        for(dynamic i in jsonRes){
          questions.add(Question.fromJson(i));
        }

        return questions;
      } else {
        print("Failed to fetch questions. Status Code: ${res.statusCode}");
        return [];
      }
    }catch(e){
      print(e.toString());
      return [];
    }
  }
  
}
