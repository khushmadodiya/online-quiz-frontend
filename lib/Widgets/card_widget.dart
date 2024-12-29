import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import '../globle.dart';
import '../resources/firestore_methso.dart';
import '../screens/offline quizes/msg_screen.dart';
import 'input_text_field.dart';

class CardWid extends StatefulWidget {
  final int index;
  final bool isspot;
  const CardWid({super.key, required this.index, this.isspot = false});

  @override
  State<CardWid> createState() => _CardWidState();
}

class _CardWidState extends State<CardWid> {
  bool flag = false;
  TextEditingController anscontroller = TextEditingController();

  void sendans(String ans, int index) async {
    hideTextInput();
    var res = await FireStoreMethos().setAns(
        ans, index.toString(), widget.isspot ? 'spot' : 'Gess');
    print(res);
    if (res == 's') {
      Fluttertoast.showToast(msg: 'Success');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: width > 600
          ? EdgeInsets.symmetric(horizontal: width / 3.5)
          : const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[900],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Image Section
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.isspot
                          ? 'assets/spot/${spot[widget.index]}'
                          : 'assets/animals/${animals[widget.index]}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Input and Actions Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height / 14,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    // Favorite Icon
                    IconButton(
                      onPressed: () {
                        setState(() {
                          flag = !flag;
                        });
                      },
                      icon: Icon(
                        flag ? Icons.favorite : Icons.favorite_outline,
                        color: flag ? Colors.deepPurple : Colors.white,
                      ),
                    ),
                    // Input Field
                    Expanded(
                      child: InputText(
                        controller: anscontroller,
                        hint: 'Enter answer...',
                        // style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // Send Icon
                    IconButton(
                      onPressed: () {
                        sendans(anscontroller.text.trim(), widget.index);
                        anscontroller.clear();
                      },
                      icon: Icon(
                        Icons.send_outlined,
                        color: Colors.deepPurple,
                      ),
                    ),
                    // Message Icon
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MsgScreen(
                              name: widget.isspot ? 'spot' : 'Gess',
                              index: widget.index,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
