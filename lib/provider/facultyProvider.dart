import 'package:flutter/cupertino.dart';
import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
import 'package:online_quiz_frontend/model/questionmodel.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';

class FacultyProvider extends ChangeNotifier{
  List<Quiz> _quizzes=[];
  List<Question> _questions=[];


  List<Quiz> get quizzes => _quizzes;
  List<Question> get questions => _questions;

  void getAllquizzesList(String facultyId)async{
    _quizzes = await FacultyAPIs.fetchQuizStream(facultyId);
    notifyListeners();
  }

  void getAllquestionsListOfPerticularQuizId(String quizId)async{
    _questions = await FacultyAPIs.getAllquestionByQuizId(quizId);
    notifyListeners();
  }

  void clear(){
    _questions = [];
    notifyListeners();
  }

}