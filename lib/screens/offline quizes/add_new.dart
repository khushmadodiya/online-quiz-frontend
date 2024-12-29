
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../resources/storeage_method.dart';
import '../../utils/utils.dart';

class AddNewimage extends StatefulWidget {
  final collname;
  final title;
  const AddNewimage({super.key, required this.title, required this.collname});

  @override
  State<AddNewimage> createState() => _AddNewimageState();
}

class _AddNewimageState extends State<AddNewimage> {
  Uint8List? _image ;
  bool flag =false;
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
      print(_image);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(

          children: [
            SizedBox(height: 200,),
      _image!=null ? Container(
        height: 200,
        child:Image.memory(_image!)
      )
          :
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[900]
                ),
                child: IconButton(
                  icon: Icon(Icons.add_a_photo_outlined,size: 100,),
                  onPressed:selectImage,

                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple,
                  ),
                child:flag ? Center(child: CircularProgressIndicator(color: Colors.white,)) :Center(child: Text('Add New Image',style: TextStyle(fontSize: 20,),)),
                ),
                onTap: (){
                 add();

                },

              ),
            )
          ],
        ),
      ),
    );
  }
  add()async{
    setState(() {
      flag= true;
    });
     if(_image != null){
       print('hello');
       var url = await StorageMethods().storeprofile(_image!,'spot');
       var uid = Uuid().v1().substring(0,4);
       await FirebaseFirestore.instance.collection(widget.collname).doc(uid).set({
         'image':url,
         'uid':uid,
       },
           );
       print(url);
     }

    setState(() {
      flag=false;
      Navigator.pop(context);
    });
  }
}
