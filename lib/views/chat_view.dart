import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widget/chat_buble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  ChatView({
    super.key,
  });
  static String id = 'chat view';
  TextEditingController controller = TextEditingController();
  final controllerr = ScrollController();


  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> Messagelist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              Messagelist.add(MessageModel.fromjson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 33,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: controllerr,
                      itemCount: Messagelist.length,
                      itemBuilder: (context, index) {
                        return Messagelist[index].id == email
                            ? ChatBuble(messagemodel: Messagelist[index])
                            : ChatBubleForother(
                                messagemodel: Messagelist[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        messages.add(
                          {
                            kMessage: value,
                            kCreatedAt: DateTime.now(),
                            'id': email
                          },
                        );
                        controller.clear();
                        controllerr.animateTo(
                            controllerr.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        hintStyle: TextStyle(color: kPrimaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                         onPressed: (){},
                          color: kPrimaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('');
          }
        });
  }
}
