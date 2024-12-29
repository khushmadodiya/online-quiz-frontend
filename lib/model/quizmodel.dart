
class Quiz {
  final String quizId;
  final String subName;
  final String quizTitle;
  final String facultyId;
  final String? studentId;


  const Quiz(
      {required this.facultyId,
        required this.subName,
        required this.quizTitle,
        required this.quizId,
        this.studentId
      });

  


  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      facultyId: json["facultyId"]??"",
      subName: json["subName"]??"",
      quizId: json["quizId"]??"",
      quizTitle: json["quizTitle"]??"",
      studentId: json["studentId"]??"",
    );
  }
  Map<String, dynamic> toJson() => {
    "facultyId": facultyId,
    "subName": subName,
    "quizId": quizId,
    "quizTitle": quizTitle,
    "studentId":studentId
  };

}
