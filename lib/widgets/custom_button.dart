import 'package:altur/widgets/text/index.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.backgroundColor = Colors.green, required this.callback});
  final VoidCallback callback;
  final String title;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: callback,
    style:ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: 
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )
  
    ), 
    child: TextBody(text:title,color: Colors.white, fontWeight: FontWeight.bold)  
    );

  }
}