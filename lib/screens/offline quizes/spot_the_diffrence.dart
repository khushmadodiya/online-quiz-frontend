
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import '../../Widgets/card_widget.dart';
import '../../Widgets/custom_floatingbutton.dart';
import '../../Widgets/spot_card_for_online_images.dart';
import '../../globle.dart';
import '../../resources/firestore_methso.dart';
import 'add_new.dart';


class Spot extends StatefulWidget {
  const Spot({super.key});

  @override
  State<Spot> createState() => _SpotState();
}

class _SpotState extends State<Spot> {


  void sendans(ans,int index)async{

    hideTextInput();
    var res =await FireStoreMethos().setAns(ans,index.toString(),'Spot');
    print(res);
    if(res=='s'){
      Fluttertoast.showToast(msg: 'succses');
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection('spotImg').snapshots(),
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
                    return index<count ? SpotCardForOnlineImages( snap: snapshot.data!.docs[index].data(),isspot:true) : CardWid(index: index-snapshot.data!.docs.length,isspot:true);
                  });
            }
            return Center(child: CircularProgressIndicator(color: Colors.deepPurple,));

          }
      ),
      floatingActionButton:CustomFloatingbutton(ontap: (){          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewimage(title: 'Add image for spotting', collname: 'spotImg',)));
      }));

  }

}
