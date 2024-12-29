

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../Widgets/input_text_field.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';

class CreateQuizDialog extends StatefulWidget {
  const CreateQuizDialog({super.key});

  @override
  State<CreateQuizDialog> createState() => _CreateQuizDialogState();
}

class _CreateQuizDialogState extends State<CreateQuizDialog> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController subjectcontroller = TextEditingController();

  _submit() async {
    String uid = Uuid().v1().substring(1,6);
   var pro =  Provider.of<UserInformation>(context,listen: false);
   var facultyPro =  Provider.of<FacultyProvider>(context,listen: false);
    Quiz quiz = Quiz(
        facultyId: pro.userId,
        subName: subjectcontroller.text.trim(),
        quizTitle: titlecontroller.text.trim(),
        quizId: uid,
        );
    String res = await FacultyAPIs.createQuiz(quiz, pro.userId);
    if (res == 'success') {
      facultyPro.getAllquizzesList(pro.userId);
      shosnacbar(context, res);
      Navigator.pop(context);
    }
    else{
      print(res);
      shosnacbar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width/1.6,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Quiz",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                InputText(controller: titlecontroller, hint: "Enter Quiz Title"),
                const SizedBox(height: 20),
                InputText(controller: namecontroller, hint: "Enter Your Name (optional)r"),
                const SizedBox(height: 20),
                InputText(
                  controller: subjectcontroller,
                  hint: "Enter Subject Name (optional)",
                ),
                const SizedBox(height: 30),
                FilledButton(onPressed: _submit, child: const Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Function to show the dialog
void showCreateQuizDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const CreateQuizDialog();
    },
  );
}
