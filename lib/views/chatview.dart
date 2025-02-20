import 'package:chatapp/constant.dart';
import 'package:chatapp/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/models/message_Model.dart';
import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chatview extends StatelessWidget {
  static const String id = 'chatview';
  TextEditingController messageController = TextEditingController();

  final controller = ScrollController();
  List<MessageModel> messagelist = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/Male.png', width: 40, height: 40),
            Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              var messagelist =
                  BlocProvider.of<ChatCubit>(context).messagesList;
              return ListView.builder(
                  reverse: true,
                  controller: controller,
                  itemCount: messagelist.length,
                  itemBuilder: (context, index) {
                    return messagelist[index].id == email
                        ? chatbubble(
                            messageModel: messagelist[index],
                          )
                        : chatbubblefromuser(
                            messageModel: messagelist[index]);
                  });
            },
          ),
        ),
        TextField(
          controller: messageController,
          style: TextStyle(color: Colors.white),
          onSubmitted: (value) {
            BlocProvider.of<ChatCubit>(context)
                .sendMessage(message: value, email: email);
            messageController.clear();
            controller.animateTo(controller.position.maxScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn);
          },
          decoration: InputDecoration(
            suffix: Icon(
              Icons.send,
              color: Colors.white,
            ),
            hintText: 'Enter your message',
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ]),
    );
  }
}
