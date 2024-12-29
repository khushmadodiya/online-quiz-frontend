import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:online_quiz_frontend/provider/userInfo.dart';
import 'package:provider/provider.dart';

import '../Widgets/input_text_field.dart';
import '../main.dart';
import '../resources/auth_methods.dart';
import 'HomeScreen.dart';





class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   setControllers();
  }
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<UserInformation>(
      builder: (context,pro,child)=>
      Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.deepPurple,
          title: Text('Profile',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600
          ),),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: MediaQuery.of(context).size.width > 600
                ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
                : const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.deepPurple),),
                SizedBox(height: 30,),
              CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(pro.photoUrl),
                ),
                const SizedBox(
                  height: 24,
                ),
                InputText(
                  hint: 'Enter your username',
                  controller: _usernameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                InputText(
                  hint: 'Enter your email',
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: (){
                    AuthMethod().signOut();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);

                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.deepPurple,
                    ),
                    child: !_isLoading
                        ? const Text(
                      'Logout',style: TextStyle(fontSize: 20,color: Colors.white),
                    )
                        : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void setControllers() {
    var pro = Provider.of<UserInformation>(context,listen: false);
    _usernameController.text = pro.userName;
    _emailController.text = pro.email;
  }



}
