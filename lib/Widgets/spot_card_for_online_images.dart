import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import '../globle.dart';
import '../resources/firestore_methso.dart';
import '../screens/offline quizes/msg_screen.dart';
import '../screens/offline quizes/online_msg_Screen.dart';
import 'input_text_field.dart';

class SpotCardForOnlineImages extends StatefulWidget {
  final snap;
  final isspot;
  const SpotCardForOnlineImages({super.key, this.isspot=false, required this.snap});

  @override
  State<SpotCardForOnlineImages> createState() => _SpotCardForOnlineImagesState();
}

class _SpotCardForOnlineImagesState extends State<SpotCardForOnlineImages> {
  bool flag =false;
  TextEditingController anscontroller = TextEditingController();
  void sendans(ans,String uid)async{

    hideTextInput();
    var res =await FireStoreMethos().setAns(ans,uid,widget.isspot ? 'spotImg': 'GuessImg');
    print(res);
    if(res=='s'){
      Fluttertoast.showToast(msg: 'succses');
    }


  }
  @override
  Widget build(BuildContext context) {
    var Width = MediaQuery.of(context).size.width;
    return Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 3.5)
            : const EdgeInsets.symmetric(horizontal: 0),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: Container(
              height: MediaQuery.of(context).size.height/3.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black
              ),
              child:
              Column(
                  children: [
                    Container(height:MediaQuery.of(context).size.height/4,width:double.infinity,child: Image.network(widget.snap['image'])),
                    Container(
                        height: MediaQuery.of(context).size.height/14,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              if(flag){
                                setState(() {
                                  flag=false;
                                });
                              }
                              else{
                                setState(() {
                                  flag=true;
                                });
                              }
                            }, icon: flag ?  Icon(Icons.favorite,color: Colors.deepPurple,):Icon( Icons.favorite_outline)),
                            Expanded(
                                child: InputText(controller: anscontroller, hint: '   Enter answer ..')
                            ),
                            IconButton(onPressed: (){
                              sendans(anscontroller.text.trim(),widget.snap['uid'].toString());
                              anscontroller.clear();
                            }, icon: Icon(Icons.send_outlined,color: Colors.deepPurple,)),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OnlineMsgScreen(name: widget.isspot ? 'spotImg':'GuessImg', index: widget.snap['uid'])));
                            }, icon: Icon(Icons.message ,))
                          ],
                        )
                    ),
                  ]
              ),
            )
        )
    );
  }
}
