import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:online_quiz_frontend/model/usermodel.dart';

class Marks {
  final String marksId;
  final int? marksObtained;
  final bool? status;
  final Quiz? quiz;
  final User? student;
  final User? faculty;
  final String quizId;
  final String studentId;

  Marks(
      {required this.marksId,
      this.marksObtained,
      this.status,
        this.quiz,
       this.student,
       this.faculty,
      required this.quizId,
      required this.studentId});

  factory Marks.fromJson(Map<String, dynamic> json) => Marks(
      marksId: json['marksId'],
      marksObtained: int.tryParse(json['marksObtained'] ?? "0"),
      status: json["status"] == "0" ? false : true,
      quiz: Quiz.fromJson(json['quiz']),
      student: User.fromJson(
        json['student'],
      ),
      faculty: User.fromJson(json["quiz"]?["faculty"]),
      quizId: '',
      studentId: '');

  Map<String, dynamic> toJson() => {
        "marksId": marksId,
        "marksObtained": marksObtained,
        "status": status == true ? "1" : "0",
        "quiz": quiz?.toJson(),
        "student": student?.toJson(),
        "faculty": faculty?.toJson(),
        "studentId":studentId,
        "quizId":quizId,
      };
}
