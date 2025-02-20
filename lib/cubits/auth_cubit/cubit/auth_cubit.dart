import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> LoginUser(
      {required String email, required String password}) async {
    try {
      emit(LoginLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'errror'));
    }
  }
   Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      emit(RegisterLoading());
      FirebaseAuth.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          RegisterFailure(errorMessage: 'weak-password'),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          RegisterFailure(
              errorMessage: 'The account already exists for that email.'),
        );
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errorMessage: 'error'));
    }
  }
}
