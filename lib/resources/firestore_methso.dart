
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FireStoreMethos {
  Future<String> createquiz(
      {required String quiztitle,
      required String name,
      required String subname}) async {

    String res = 'some error occure';
   try{
     var quizuid = Uuid().v1().substring(0,4);
     await _firestore.collection('quiz').doc(quizuid).set({
       'facultyuid': FirebaseAuth.instance.currentUser!.uid,
       'quizuid': quizuid,
       'quiztitle': quiztitle,
       'name': name,
       'subname': subname
     }).onError((error, stackTrace) => res = 'some error occure $error');
     res = 'success';
     return res;
   }
   catch(e){
     res = "error occured $e";

   }
   return res;
  }

  Future<String> deleteequiz({required String quizuid}) async {
    String res = 'some error occure';
    try{
      await _firestore
          .collection('quiz')
          .doc(quizuid)
          .delete()
          .onError((error, stackTrace) => res = 'some error occure $error');
      res = 'success';
      return res;
    }
    catch(e){
      res = "error occured $e";
    }
    return res;
  }

  Future<String> addquestion(
      {required String question,
      required String option1,
      required String option2,
      required String option3,
      required String option4,
      required String rightans,
      required String quid}) async {
    var uid = Uuid().v1().substring(0,4);
    String res = 'some error occure';
   try{
     await _firestore
         .collection('quiz')
         .doc(quid)
         .collection('questions')
         .doc(uid)
         .set({
       'question': question,
       'option1': option1,
       'option2': option2,
       'option3': option3,
       'option4': option4,
       'ans': rightans,
       'quesuid': uid
     }).onError((error, stackTrace) => res = 'some error occure $error');
     res = 'success';
     return res;
   }
    catch(e){
    res = "error occured $e";
    }
    return res;

  }

  Future<String> editquestion(
      {required String question,
      required String option1,
      required String option2,
      required String option3,
      required String option4,
      required String rightans,
      required String quid,
      required String quesuid}) async {
    String res = 'some error occure';
    try{
      await _firestore
          .collection('quiz')
          .doc(quid)
          .collection('questions')
          .doc(quesuid)
          .update({
        'question': question,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'option4': option4,
        'ans': rightans
      }).onError((error, stackTrace) => res = 'some error occure $error');
      res = 'success';
      return res;
    }
    catch(e){
      res = "error occured $e";
    }
    return res;
  }

  Future<String> deletequestion(
      {required String quid, required String quesuid}) async {
    String res = 'some error occure';
   try{
     await _firestore
         .collection('quiz')
         .doc(quid)
         .collection('questions')
         .doc(quesuid)
         .delete()
         .onError((error, stackTrace) => res = 'some error occure $error');
     res = 'success';
     return res;
   }
   catch(e){
     res = "error occured $e";
   }
    return res;
  }

  Future<String> add_student_to_quiz({
    required String quid,
  }) async {
    String res = 'some error occure';
    try{
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('quiz').doc(quid).get();
      int count = await getQuestionCount(quid);
      print('Question count: $count');
      print(count);
      for (int i = 1; i <= count; i++) {
        print(i);
        print(_auth.currentUser!.uid);
        if (i == 1) {
          await _firestore
              .collection('quiz')
              .doc(quid)
              .collection('students')
              .doc(_auth.currentUser!.uid)
              .set({'$i': 0}).catchError((er) {
            res = 'error $er';
          });
        } else {
          await _firestore
              .collection('quiz')
              .doc(quid)
              .collection('students')
              .doc(_auth.currentUser!.uid)
              .update({'$i': 0}).catchError((er) {
            res = 'error $er';
          });
        }
      }

      await _firestore
          .collection('quiz')
          .doc(quid)
          .collection('students')
          .doc(_auth.currentUser!.uid)
          .update({
        'studentuid': _auth.currentUser!.uid,
        'status': false,
        'marks': 0,
      }).onError((error, stackTrace) => res = 'some error occure $error');
      String isfirst = await _firestore
          .collection('student')
          .doc(_auth.currentUser!.uid)
          .collection('quizes')
          .where('quizuid', isEqualTo: quid)
          .toString();
      if (isfirst != quid) {
        await _firestore
            .collection('student')
            .doc(_auth.currentUser!.uid)
            .collection('quizes')
            .doc(quid)
            .set({
          'quizuid': quid,
          'quiztitle': snapshot['quiztitle'].toString(),
          'name': snapshot['name'].toString(),
          'subname': snapshot['subname'].toString(),
          'status': false,
        }).onError((error, stackTrace) => res = 'some error occure $error');
      }
      res = 'success';
      return res;
    }
    catch(e){
      res = "error occured $e";
    }
    return res;
  }

  Future<String> updateans({
    required String quid,
    required int index,
  }) async {
    String res = 'erro occured';
   try{
     await _firestore
         .collection('quiz')
         .doc(quid)
         .collection('students')
         .doc(_auth.currentUser!.uid)
         .update({'$index': 1}).catchError((er) {
       res = 'error $er';
     });
     res = 'success';
     return res;
   }
   catch(e){
     res = 'error occured $e';
   }
   return res;
  }

  Future<String> updatetozero({
    required String quid,
    required int index,
  }) async {
    String res = 'erro occured';
    try{
      await _firestore
          .collection('quiz')
          .doc(quid)
          .collection('students')
          .doc(_auth.currentUser!.uid)
          .update({'$index': 0}).catchError((er) {
        res = 'error $er';
      });
      res = 'success';
      return res;
    }
    catch(e){
      res = 'errror occured $e';
    }
    return res;
  }

  Future<String> submitQuiz({
    required String quid,
    required int lenght,
  }) async {
    String res = 'erro occured';
   try{
     int count =0;
     print(lenght);
     DocumentSnapshot snapshot = await _firestore.collection('quiz').doc(quid).collection('students').doc(_auth.currentUser!.uid).get();
     // print(snapshot['1']);
     for(int i=1;i<=lenght ; i++){
       if(snapshot['$i']==1){
         count+=1;
       }
     }
     await _firestore
         .collection('quiz')
         .doc(quid)
         .collection('students')
         .doc(_auth.currentUser!.uid)
         .update({'marks':count,'totalmarks':lenght}).onError((error, stackTrace) => res= 'error occured');
     await _firestore.collection('student').doc(_auth.currentUser!.uid).collection('quizes').doc(quid).update(
         {
           'status':true
         }).onError((error, stackTrace) => res='error occured');
     res = 'success';
     return res;
   }
   catch(e){
     res='error occured $e';
   }
   return res;
   }

  Future<String> setAns(String ans,String collname,String maincollectionname)async{
    try{
      String res = 'Error occured';
      DateTime now = DateTime.now();
      String formattedDate = DateFormat.yMMMMd().format(now);
      // String devicename = await getDeviceName();
      var uid = Uuid().v1().substring(0,4);
      FirebaseFirestore.instance.collection(maincollectionname).doc(collname).collection('uid').doc(uid).set({
        'ans':ans,
        // 'device':devicename,
        'time':'${formattedDate}'
      });
        res = 's';
        return res;
    }
    catch(e){
      print('error');
      return 'error';
    }
  }
} //class

Future<int> getQuestionCount(String quid) async {
  try {
    print(quid);
    var querySnapshot = await FirebaseFirestore.instance
        .collection('quiz')
        .doc(quid)
        .collection('questions')
        .get();

    return querySnapshot.size; // This gives you the count of documents
  } catch (e) {
    print('Error getting question count: $e');
    return 0; // Return 0 in case of an error
  }
}//method
// Future<String> getDeviceName() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     print('Device name: ${androidInfo.model}');
//     return androidInfo.model;
//   } else if (Platform.isIOS) {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     print('Device name: ${iosInfo.name}');
//     return iosInfo.model;
//   }
//   return '';
// }



