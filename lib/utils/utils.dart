import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


final value1 = 'Student';
final value2 = 'Faculty';
final option1 = 'option1';
final option2 = 'option2';
final option3 = 'option3';
final option4= 'option4';
final webScreenSize = 600;
final useruid = FirebaseAuth.instance.currentUser!.uid;
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}
shosnacbar(BuildContext context,String text){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(child: Text(text)),)
  );

}