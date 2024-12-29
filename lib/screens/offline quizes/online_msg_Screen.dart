import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class OnlineMsgScreen extends StatefulWidget {
  final name;
  final index;
  const OnlineMsgScreen({super.key, required this.name, required this.index});

  @override
  State<OnlineMsgScreen> createState() => _OnlineMsgScreenState();
}

class _OnlineMsgScreenState extends State<OnlineMsgScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    circle();
  }
  void circle(){
    print('hello');
    Timer(
        Duration(seconds: 6),
            (){
          CircularProgressIndicator(color: Colors.deepPurple,);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Answers'),
      ),
      body: Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 4)
            : const EdgeInsets.symmetric(horizontal: 5),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(widget.name).doc(widget.index.toString()).collection('uid').snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              Center(child: CircularProgressIndicator(color: Colors.deepPurple,));
            }
            else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            height: 60,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.2,
                            decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(2),
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),)
                            ),
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 5),
                                      child: Text(
                                        snapshot.data!.docs[index].data()['ans'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),),
                                    ),
                                  ),
                                  // Expanded(child: SizedBox()),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 12),
                                    child: Text(
                                      snapshot.data!.docs[index].data()['time'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),),
                                  ),

                                ]
                            ),
                          ),

                        ],
                      ),
                    );
                  }

              );
            }
            return Center(child: CircularProgressIndicator(color: Colors.deepPurple,));
          },
        ),
      ),
    );
  }
}
