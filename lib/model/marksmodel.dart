

class Marks {
  final String marksId;
  final int? marksObtained;
  final bool? status;
  final String quizId;
  final String studentId;

  Marks({
    required this.marksId,
    this.marksObtained,
    this.status,
    required this.quizId,
    required this.studentId,
  });

  factory Marks.fromJson(Map<String, dynamic> json) => Marks(
    marksId: json['marksId'],
    marksObtained: int.parse(json['marksObtained']),
    status: json["status"],
    quizId: json["quizId"],
    studentId: json["studentId"],
  );

  Map<String, dynamic> toJson() => {
    "marksId": marksId,
    "marksObtained": marksObtained,
    "status": status,
    "quizId": quizId,
    "studentId": studentId,
  };
}
