import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:online_quiz_frontend/BackendAPIs/GetUserDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usermodel.dart'as model;
import '../utils/utils.dart';

class UserInformation extends ChangeNotifier {
  String _userName = '';
  String _userId = '';
  String _userType = '';
  String _email = '';
  String _photoUrl = '';

  String get userType => _userType;
  String get userId => _userId;
  String get userName => _userName;
  String get email => _email;
  String get photoUrl => _photoUrl;


  Future getUserData() async {

      var pref = await SharedPreferences.getInstance();
      print("this is key from userinfo");
      print(pref.getString('key'));

      var usertype = pref.getString('key').toString();
      if(usertype==value1 || usertype == value2){
        var uid = FirebaseAuth.instance.currentUser!.uid;
        model.User user =  await GetUserDetails.fetchUserWithId(uid,usertype==value1?'student':'faculty');
        _userType = usertype ?? '';
        _userId =  user.uid?? '';
        _userName = user.username?? '';
        _email = user.email ?? '';
        _photoUrl = user.photoUrl ?? '';
        print("this is photo url $_photoUrl");
      }else{
        return "user not found";
      }
      notifyListeners();
      return 'success';

  }


  void clear(){
    _userName = '';
    _userId = '';
    _userType = '';
    _email = '';
    _photoUrl = '';
    notifyListeners();
  }
}
