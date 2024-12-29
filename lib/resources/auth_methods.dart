
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_quiz_frontend/BackendAPIs/StudentAPIs.dart';
import 'package:online_quiz_frontend/resources/storeage_method.dart';
import 'package:uuid/uuid.dart';
import '../model/usermodel.dart' as model;
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
const url = 'http://localhost:8080';
class AuthMethod {
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> signup(
      {required String email,
      required String password,
      required String name,
      required Uint8List file,
      required String usertype}) async {
    String res = 'some error occure';
    try {
      if(name.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          file.isEmpty ||
          usertype.isEmpty){
        res  = "Please fill all the field with image";
        return res;
      }
      if (name.isNotEmpty &&
          email.isNotEmpty&&
          password.isNotEmpty &&
          file.isNotEmpty &&
          usertype.isNotEmpty) {
        UserCredential cred = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password));
        String photoUrl = await StorageMethods().storeprofile(file,'profile');


        model.User user = model.User(
          username: name,
          email: email,
          photoUrl: photoUrl,
          usertype: usertype,
          uid: cred.user!.uid,
        );
        String res = "Some error occured";
        if (usertype == value1) {
          // await _firestore
          //     .collection('student')
          //     .doc(cred.user!.uid)
          //     .set(user.toJson());

         res = await  StudentAPIs().createUser(user,'student');

        } else {
          // await _firestore
          //     .collection('faculty')
          //     .doc(cred.user!.uid)
          //     .set(user.toJson());

           res= await StudentAPIs().createUser(user,'faculty');

        }
        if(res=="Failed to Create User"){
         var res= await StorageMethods().deletfile("profile");
          if(res=="s"){
            _auth.currentUser?.delete();
          }
        }
        return res;
      }

    } catch (e) {
      res = "some error occur : $e";
      return res;
    }
    return res;
  }
  Future<String> loginUser({
    required String email,
    required String password,
    required String type
  }) async {
    String res = "Some error Occurred";
    try {

      if (email.isNotEmpty && password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> signOut() async {
    String res='error';
    await _auth.signOut().onError((error, stackTrace) => res='error');
    res='success';
    return res;
  }
}
