import 'package:chatapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapp/cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:chatapp/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/views/chatview.dart';
import 'package:chatapp/views/loginview.dart';
import 'package:chatapp/views/registerview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        routes: {
          Loginview.id: (context) => Loginview(),
          Registerview.id: (context) => Registerview(),
          Chatview.id: (context) => Chatview(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: Loginview.id,
      ),
    );
  }
}
