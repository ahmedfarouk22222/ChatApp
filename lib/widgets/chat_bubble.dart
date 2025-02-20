import 'package:chatapp/models/message_Model.dart';
import 'package:flutter/material.dart';

class chatbubble extends StatelessWidget {
  const chatbubble({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        margin: EdgeInsets.all(15),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Text(messageModel.message),
      ),
    );
  }
}

class chatbubblefromuser extends StatelessWidget {
  const chatbubblefromuser({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
        margin: EdgeInsets.all(15),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Text(messageModel.message),
      ),
    );
  }
}
