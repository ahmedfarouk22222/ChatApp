import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          try {
            emit(LoginLoading());
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
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
        } else if (event is RegisterEvent) {
          try {
            emit(RegisterLoading());
            FirebaseAuth.instance;
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: event.email, password: event.password);
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
      },
    );
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
}
