import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
class StorageMethods{
 Future<String> storeprofile(Uint8List file,String s)async{
    var uid = Uuid().v1().substring(0,4);
    Reference ref =  s=='spot'?_storage.ref().child(s).child(uid): _storage.ref().child(s).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();

    return url;

  }

  Future deletfile(String s)async{
   var ref = await _storage.ref(s).child(_auth.currentUser!.uid);
   ref.delete();
   return  "s";
  }

}