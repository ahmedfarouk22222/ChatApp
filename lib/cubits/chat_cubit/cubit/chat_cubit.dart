 import 'package:bloc/bloc.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/models/message_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  List<MessageModel> messagesList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {
          kmessage: message,
          kTimeMessage: DateTime.now(),
          'id': email,
        }, //map
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessage() {
    messages.orderBy(kTimeMessage, descending: true).snapshots().listen(
      (event) {
        messagesList.clear();
        for (var doc in event.docs) {
          messagesList.add(MessageModel.fromjson(doc.data()));
        }
        emit(ChatSuccess(messagesList: messagesList));
      },
    );
  }
}
