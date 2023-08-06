import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_with_firebase/auth/data/auth_services.dart';
import 'package:todo_app_with_firebase/auth/data/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices;
  AuthBloc({
    required this.authServices,
  }) : super(AuthState()) {
    on<LoginEvent>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              isLoading: true,
              errorLoading: false,
              successLoading: false,
            ),
          );
          var user = await authServices.loginWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          emit(
            state.copyWith(
              user: user,
              isLoading: false,
              errorLoading: false,
              successLoading: true,
            ),
          );
        } on FirebaseAuthException catch (e) {
          print(e);
          emit(
            state.copyWith(
              isLoading: false,
              errorLoading: true,
              successLoading: false,
              message: e.message,
            ),
          );
        } catch (e) {
          print(e);
          emit(
            state.copyWith(
              isLoading: false,
              errorLoading: true,
              successLoading: false,
              message: e.toString(),
            ),
          );
        }
      },
    );

    on<RegisterEvent>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              isLoading: true,
              errorLoading: false,
              successLoading: false,
            ),
          );
          var user = await authServices.registerWithEmailAndPassword(
            email: event.email,
            password: event.password,
            firstName: event.fisrtName,
            lastName: event.lastName,
            image: event.image,
          );

          emit(
            state.copyWith(
              user: user,
              isLoading: false,
              errorLoading: false,
              successLoading: true,
            ),
          );
        } on FirebaseAuthException catch (e) {
          print(e);
          emit(
            state.copyWith(
              isLoading: false,
              errorLoading: true,
              successLoading: false,
              message: e.message,
            ),
          );
        } catch (e) {
          print(e);
          emit(
            state.copyWith(
              isLoading: false,
              errorLoading: true,
              successLoading: false,
              message: e.toString(),
            ),
          );
        }
      },
    );

    on<CheckAuthStateEvent>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              isCheckingAuthState: true,
              errorCheckingAuthState: false,
              successCheckingAuthState: false,
            ),
          );
          var user = await authServices.checkAuthState();
          if (user != null) {
            emit(
              state.copyWith(
                user: user,
                isCheckingAuthState: false,
                errorCheckingAuthState: false,
                successCheckingAuthState: true,
              ),
            );
          } else {
            emit(
              state.copyWith(
                isCheckingAuthState: false,
                errorCheckingAuthState: true,
                successCheckingAuthState: false,
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              isCheckingAuthState: false,
              errorCheckingAuthState: true,
              successCheckingAuthState: false,
            ),
          );
          print(e);
        }
      },
    );
  }
}
