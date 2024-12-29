import 'package:cloud_firestore/cloud_firestore.dart';

class FetchQuestions{
  Future<List<Map<String,String>>> fetch(String quizuid)async{
        QuerySnapshot snapshot =  await FirebaseFirestore.instance .collection('quiz').doc(quizuid).collection('questions').get();
        List<Map<String,String>> questions=[];
        snapshot.docs.forEach((doc) {
            Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
            Map<String, String> oneques = {
              'question':data['question'],
              'option1':data['option1'],
              'option2': data['option2'],
              'option3': data['option3'],
              'option4': data['option4'],
              'ans':data['ans'],
            };
            questions.add(oneques);
        });
        print(questions);
        return questions;
  }

}