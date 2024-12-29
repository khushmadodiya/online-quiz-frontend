import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import '../../Widgets/card_widget.dart';
import '../../Widgets/custom_floatingbutton.dart';
import '../../Widgets/spot_card_for_online_images.dart';
import '../../globle.dart';
import 'add_new.dart';
class Guess extends StatefulWidget {
  const Guess({super.key});

  @override
  State<Guess> createState() => _GuessState();
}

class _GuessState extends State<Guess> {
  final TextEditingController anscontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection('GuessImg').snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              Center(child: CircularProgressIndicator(color: Colors.deepPurple,));
            }
            else{
              var count= snapshot.data!.docs.length;
              print(count);
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length+spot.length,
                  itemBuilder: (context,index){
                    return index<count ? SpotCardForOnlineImages( snap: snapshot.data!.docs[index].data()) : CardWid(index: index-snapshot.data!.docs.length);
                  });
            }
            return Center(child: CircularProgressIndicator(color: Colors.deepPurple,));

          }
      ),

      floatingActionButton: CustomFloatingbutton(ontap: (){          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewimage(title: 'Add Image for Guessing', collname: 'GuessImg',)));
      })
    );
  }
}
