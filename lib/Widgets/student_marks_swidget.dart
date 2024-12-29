import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/utils.dart';

class StudentMarksWidget extends StatefulWidget {
  final snap;
  final index;
  const StudentMarksWidget({super.key, required this.snap, this.index});

  @override
  State<StudentMarksWidget> createState() => _StudentMarksWidgetState();
}

class _StudentMarksWidgetState extends State<StudentMarksWidget> {
  String name ='';
  String email ='';
  bool flag=true;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return name==''?Center(child: CircularProgressIndicator(),) :Container(
        margin: EdgeInsets.symmetric(
          horizontal: width > webScreenSize ? width * 0.3 : 30,
          vertical: width > webScreenSize ? 15 : 10,
        ),
        // height: MediaQuery.of(context).size.height / 8,
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            widget.index==1?
            Row(
              children: [
                Text(
                  'NO.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

                ),
                Expanded(child: SizedBox()),
                Text(
                  'Name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  'Marks',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),

              ],
            ):Container(),
            // Size/dBox(height: 20,),
            Divider(thickness: 1,color: Colors.white,height: 20,),
            Row(
              children: [
                Text(
                  '${widget.index}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

                ),
                 Expanded(child: SizedBox()),
                Text(
                  name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  email,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Text(
                  widget.snap['marks'].toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),

              ],
            ),
            // Divider(thickness: 1,color: Colors.white,height: 20,)
          ],
        )
    );

  }

  void getname() async{
   String uid = widget.snap['studentuid'].toString();
   try{
     DocumentSnapshot snapshot =await FirebaseFirestore.instance.collection('student').doc(uid).get();
     setState(() {
       name = snapshot['username'];
       email =snapshot['email'];
     });

     print(name);
   }
   catch(e){
     print('error occured');
   }
  }
}
