import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../globle.dart';
import 'package:http/http.dart'as http;

import '../model/usermodel.dart'as model;
class GetUserDetails{


  static Future fetchUserWithId(String uid,String userType) async {

    final response = await http.get(Uri.parse('$url/$userType/$uid'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<model.User>list= jsonResponse.map((student) => model.User.fromJson(student)).toList();
      for(model.User i in list){
        print(i.uid);
        print(i.username);
        print(i.email);
        print(i.photoUrl);
      }
      return list[0];
    } else {
      Fluttertoast.showToast(msg: "user not found");
      throw Exception('Failed to load students');
    }
  }
}