import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
 const CustomButton({ required this.onPressed, required this.buttonName});
 final VoidCallback onPressed;
 final String buttonName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonName),
      ),
    );
  }
}
