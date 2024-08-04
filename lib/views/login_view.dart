import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showSnackbar.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widget/custom_form_text_field.dart';
import 'package:chat_app/widget/cusyom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;

  String? password;

  bool? isLoading;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              const SizedBox(
                height: 120,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Image.asset(
                  'assets/Male.png',
                  height: 125,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scholar Chat',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 65,
              ),
              const Row(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormTextField(
                onchanged: (data) {
                  email = data;
                },
                hintText: 'Email',
              ),
              const SizedBox(height: 13),
              CustomFormTextField(
                obsecure: true,
                onchanged: (data) {
                  password = data;
                },
                hintText: 'Password',
              ),
              const SizedBox(
                height: 30,
              ),
              CustomBotton(
                  bottomName: 'Login',
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        showSnackBar(context, 'Successfully Login');
                        Navigator.pushNamed(context, ChatView.id,arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for the email: $email');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password for the user with email: $email');
                        }
                        ;
                        // Log the exception using a logging library or service
                      } catch (e) {
                        showSnackBar(context,
                            'An unexpected error occurred. Please try again later.');
                        // Log the exception using a logging library or service
                      }
                    }
                  }),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'don\'t have an account ? ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterView.id);
                    },
                    child: const Text(
                      '   Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    FirebaseAuth.instance;
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
