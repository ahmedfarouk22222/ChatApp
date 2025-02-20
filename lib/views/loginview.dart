import 'package:chatapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/views/chatview.dart';
import 'package:chatapp/views/registerview.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:chatapp/widgets/snackbarmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginview extends StatelessWidget {
  String? email;
  static String id = 'loginView';
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showSpinner = true;
        } else if (state is LoginSuccess) {
          snackbarMessage(context, 'login success');
          Navigator.pushNamed(context, Chatview.id, arguments: email);
          BlocProvider.of<ChatCubit>(context).getMessage();

          showSpinner = false;
        } else if (state is LoginFailure) {
          showSpinner = false;
          snackbarMessage(context, state.errorMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Image.asset(
                  'lib/assets/images/Male.png',
                  width: 200,
                  height: 200,
                ),
                Text(
                  'Scholar Chat',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ],
                ),
                custom_textField(
                  onChanged: (value) {
                    email = value;
                  },
                  hint: 'User Name',
                ),
                custom_textField(
                  hint: 'password',
                  obsecure: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                CustomButton(
                  buttonName: 'Login',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(
                        LoginEvent(email: email!, password: password!),
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registerview(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
