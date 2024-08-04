import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/showSnackbar.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widget/custom_form_text_field.dart';
import 'package:chat_app/widget/cusyom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
 const RegisterView({super.key});
  static String id = 'RigisterPage';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Scaffold(
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
                      'Register',
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
                  onchanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomBotton(
                  bottomName: 'Register',
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoding = true;
                      setState(() {});

                      try {
                        await registerUser();
                        showSnackBar(context, 'successfully Registered');
                        Navigator.pushNamed(context, ChatView.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    isLoding = false;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account ? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'LoginView');
                      },
                      child: const Text(
                        '   Login',
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
      ),
    );
  }

  Future<void> registerUser() async {
    FirebaseAuth.instance;
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
