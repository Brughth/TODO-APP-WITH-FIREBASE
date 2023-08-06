part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckAuthStateEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String fisrtName;
  final String lastName;
  final String image;
  RegisterEvent({
    required this.email,
    required this.password,
    required this.fisrtName,
    required this.lastName,
    required this.image,
  });
}
