import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFloatingbutton extends StatelessWidget {
  final VoidCallback ontap;
  const CustomFloatingbutton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // Set your desired radius here
      ),
      onPressed: ontap,
      child: Icon(Icons.add),

    );
  }
}
