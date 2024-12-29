import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/BackendAPIs/FacultyAPIs.dart';
import 'package:online_quiz_frontend/model/questionmodel.dart';
import 'package:online_quiz_frontend/model/quizmodel.dart';
import 'package:online_quiz_frontend/provider/facultyProvider.dart';
import 'package:online_quiz_frontend/screens/faculty/question_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../Widgets/input_text_field.dart';
import '../../resources/firestore_methso.dart';
import '../../utils/utils.dart';
class AddQuestion extends StatefulWidget {
  final Quiz quiz;
  const AddQuestion({super.key, required this.quiz});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController questioncontroller = TextEditingController();
  TextEditingController option1controller = TextEditingController();
  TextEditingController option2controller = TextEditingController();
  TextEditingController option3controller = TextEditingController();
  TextEditingController option4controller = TextEditingController();
  String selectedValue = 'option1';

  _submit()async{
    String uid = Uuid().v1().substring(1,8);
    var facultyPro = Provider.of<FacultyProvider>(context,listen: false);
   Question question =Question(
       questionName: questioncontroller.text.trim(),
       option1: option1controller.text.trim(),
       option2: option2controller.text.trim(),
       option3: option3controller.text.trim(),
       option4: option4controller.text.trim(),
       ans: selectedValue,
       quizId:widget.quiz.quizId,
       questionId: uid);
    String res = await FacultyAPIs.createQuestion(question);
    if(res=='success'){
     facultyPro.getAllquestionsListOfPerticularQuizId(widget.quiz.quizId);
     shosnacbar(context, "Question Created Successfully");
     Navigator.pop(context);
    }else{
      shosnacbar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: Width > 600
                ? EdgeInsets.symmetric(horizontal: Width / 2.9)
                : const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  InputText(controller: questioncontroller, hint: "Enter Question"),
                  SizedBox(
                    height: 20,
                  ),
                  InputText(controller:option1controller, hint: "Enter option 1"),
                  SizedBox(
                    height: 20,
                  ),
                  InputText(controller:option2controller, hint: "Enter option 2"),
                  SizedBox(
                    height: 20,
                  ),
                  InputText(controller:option3controller, hint: "Enter option 3"),
                  SizedBox(
                    height: 20,
                  ),
                  InputText(controller:option4controller, hint: "Enter option 4"),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Select right option'),
                  SizedBox(height: 5,),
                  DropdownButton<String>(
                    hint: Text('select right option',style: TextStyle(color: Colors.black),),
                    borderRadius: BorderRadius.circular(10),
                    icon: Icon(Icons.person),
                    iconEnabledColor: Colors.deepPurple,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: <String>[
                      option1,
                      option2,
                      option3,
                      option4
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FilledButton(onPressed: _submit, child: Text('  Submit  ')),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
