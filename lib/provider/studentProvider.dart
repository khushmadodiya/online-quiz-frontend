import 'package:flutter/cupertino.dart';
import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
import 'package:online_quiz_frontend/BackendAPIs/StudentAPIs.dart';
import 'package:online_quiz_frontend/model/marksmodel.dart';
import 'package:online_quiz_frontend/model/questionmodel.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';

class StudentProvider extends ChangeNotifier{
  List<Quiz> _studentQuizzes=[];
  late  Map<int ,bool> _checkAnsOfQuestion= {};
  List<Marks> _marksList = [];


  List<Quiz> get studentQuizzes => _studentQuizzes;
  List<Marks> get marksList => _marksList;
  Map<int, bool> get checkAnsOfQuestion => _checkAnsOfQuestion;

  void getMarksByStudentId(String studentId)async{
    _marksList = await StudentAPIs.getAllMarksWithStudentId(studentId);
    notifyListeners();
  }
  void getAllquizzesList(String studentId)async{
    print("this is called");
    _studentQuizzes = await StudentAPIs.fetchQuizzes(studentId);
    notifyListeners();
  }

  void updateAnsOfQuestion(int index , String ans,String rightAns){
    print("this is ans ${ans} and $rightAns and index $index");
    if(ans == rightAns){
      _checkAnsOfQuestion[index]=true;
    }else{
      _checkAnsOfQuestion[index]=false;
    }
    print(_checkAnsOfQuestion);
    notifyListeners();
  }
  int checkAns(){
    int count=0;
    for(int i=1;i<=_checkAnsOfQuestion.length;i++){
      if(_checkAnsOfQuestion[i]==true){
        count++;
      }
    }
    return count;
  }

  void clear() {
    _checkAnsOfQuestion = {};
  }



}