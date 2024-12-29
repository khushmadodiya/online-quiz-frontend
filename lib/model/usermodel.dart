import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String usertype;


  const User(
      {required this.username,
        required this.uid,
        required this.photoUrl,
        required this.email,
        required this.usertype
     });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      usertype: snapshot['model']
    );
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json["username"]??"",
        uid: json["uid"]??"",
        email: json["email"]??"",
        photoUrl: json["photoUrl"]??"",
        usertype: "",
    );
  }
  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "model":usertype
  };

}
