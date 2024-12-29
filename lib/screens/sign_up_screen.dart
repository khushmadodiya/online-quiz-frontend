

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/input_text_field.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import 'faculty/facultyScreen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController modelcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  String selectedValue = 'Student';
  Uint8List? _image;
  bool flag= false;

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
  submit()async{
    setState(() {
      flag = true;
    });
   String res= await AuthMethod().signup(email: emailcontroller.text.trim(), password: passcontroller.text.trim(), name: namecontroller.text.trim(), file: _image!, usertype: selectedValue);
   shosnacbar(context, res);
   setState(() {
     flag = false;
   });
   if(res=='success'){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
   }



  }


  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){ FocusScope.of(context).unfocus();},
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: Width > 600
                ? EdgeInsets.symmetric(horizontal: Width / 2.9)
                : const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : Icon(Icons.person,size: 130,),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                    ),
                    bottom: -10,
                    left: 80,
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1.3)
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    icon: Icon(Icons.person),
                    iconEnabledColor: Colors.deepPurple,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        modelcontroller.text = selectedValue;
                      });
                    },
                    items: <String>[
                      value1,
                      value2,
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value,style: TextStyle(fontSize: 25),));
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InputText(controller: namecontroller, hint: "Enter your Name",),
                SizedBox(
                  height: 15,
                ),
                InputText(controller: emailcontroller, hint: "Enter your Email"),
                SizedBox(
                  height: 15,
                ),
                InputText(
                  controller: passcontroller,
                  hint: 'Enter password',
                  ispass: true,
                  isform: true,
                ),
                SizedBox(
                  height: 20,
                ),
                FilledButton(onPressed: submit, child: flag ?CircularProgressIndicator(color: Colors.white,): Text('  Sign Up  ')),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account '),
                      InkWell(
                        child: Text('Log In',style: TextStyle(color: Colors.deepPurple),),
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
