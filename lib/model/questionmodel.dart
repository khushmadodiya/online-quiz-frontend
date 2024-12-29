
class Question {
  final String questionId;
  final String questionName;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String ans;
  final String quizId;


  const Question({
   required this.questionId,
   required this.questionName,
   required this.option1,
   required this.option2,
   required this.option3,
   required this.option4,
   required this.ans,
   required this.quizId,
  });


  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId : json["questionId"]??"",
      questionName:json["questionName"]??"",
      option1:json["option1"]??"",
      option2 : json["option2"]??"",
      option3 : json["option3"]??"",
      option4: json["option4"]??"",
      ans: json["ans"]??"",
      quizId: json["quizId"]??"",
    );
  }
  Map<String, dynamic> toJson() => {
   "questionId":questionId,
    "questionName":questionName,
    "option1":option1,
    "option2":option2,
    "option3":option3,
    "option4":option4,
    "ans":ans,
    "quizId":quizId,
  };

}
