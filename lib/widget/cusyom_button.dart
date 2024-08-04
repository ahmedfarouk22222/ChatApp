import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  CustomBotton({super.key, required this.bottomName, this.ontap});
  final String bottomName;
  VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Center(
          child:  Text(
          
            bottomName,
            style:const TextStyle(color: kPrimaryColor, fontSize: 30),
          ),
        ),
        height: 45,
        width: double.infinity,
        
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
