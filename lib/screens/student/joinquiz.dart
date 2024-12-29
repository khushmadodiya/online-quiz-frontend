import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/StudentAPIs.dart';
import 'package:online_quiz_frontend/model/marksmodel.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../Widgets/input_text_field.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';
import '../faculty/facultyScreen.dart';

class JoinQuizDialoge extends StatefulWidget {
  const JoinQuizDialoge({super.key});

  @override
  State<JoinQuizDialoge> createState() => _JoinQuizDialogeState();
}

class _JoinQuizDialogeState extends State<JoinQuizDialoge> {
  bool flag = false;

  TextEditingController codecontroller = TextEditingController();
  _submit()async{
    setState(() {
      flag = true;
    });
    // String res = await FireStoreMethos().add_student_to_quiz(quid: codecontroller.text.trim());
   String uid =  Uuid().v1().substring(1,6);
   var userPro = Provider.of<UserInformation>(context,listen: false);
   Marks marks = Marks(marksId: uid, quizId: codecontroller.text.trim(), studentId: userPro.userId);
    String res = await StudentAPIs.joinQuiz(marks);

    setState(() {
      flag = false;
    });
    if(res=='success'){
     Navigator.pop(context);
    }
    shosnacbar(context, res);

  }
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: (){ FocusScope.of(context).unfocus();},
      child:   Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width/3.3,
        height: MediaQuery.of(context).size.height/3.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputText(controller: codecontroller, hint: "Enter code"),
                SizedBox(
                  height: 20,
                ),
                FilledButton(onPressed: _submit, child: flag ? CircularProgressIndicator(color: Colors.white,): Text('  Submit  ')),
                SizedBox(height: 20,)

              ],
            ),
          ),

      ),
    );
  }
}

void ShowJoinQuizDialog(BuildContext context){
  showDialog(
      context: context,
      builder: (context){return JoinQuizDialoge();});
}