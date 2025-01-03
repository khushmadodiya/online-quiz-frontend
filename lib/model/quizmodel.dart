
class Quiz {
  final String quizId;
  final String subName;
  final String quizTitle;
  final String facultyId;



  const Quiz(
      {required this.facultyId,
        required this.subName,
        required this.quizTitle,
        required this.quizId,
      });

  


  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      facultyId: json["faculty"]?['uid']??"",
      subName: json["subName"]??"",
      quizId: json["quizId"]??"",
      quizTitle: json["quizTitle"]??"",
    );
  }
  Map<String, dynamic> toJson() => {
    "facultyId": facultyId,
    "subName": subName,
    "quizId": quizId,
    "quizTitle": quizTitle,
  };

}
