import 'package:chatapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:chatapp/widgets/snackbarmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registerview extends StatelessWidget {
  bool showSpinner = false;
  static String id = 'registerView';
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          showSpinner = true;
        } else if (state is RegisterSuccess) {
          showSpinner = false;
          snackbarMessage(context, 'Register success');
          Navigator.pop(context);
        } else if (state is RegisterFailure) {
          showSpinner = false;
          snackbarMessage(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: false,
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
                        'Register',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ],
                  ),
                  custom_textField(
                    hint: 'user name',
                    email: email,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  custom_textField(
                    hint: 'password',
                    onChanged: (value) {
                      password = value;
                    },
                    password: password,
                  ),
                  CustomButton(
                    buttonName: 'Register',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          RegisterEvent(email: email!, password: password!),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
