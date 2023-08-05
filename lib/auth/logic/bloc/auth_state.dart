part of 'auth_bloc.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final bool errorLoading;
  final bool successLoading;
  final String? message;
  AuthState({
    this.user,
    this.isLoading = false,
    this.errorLoading = false,
    this.successLoading = false,
    this.message,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    bool? errorLoading,
    bool? successLoading,
    String? message,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorLoading: errorLoading ?? this.errorLoading,
      successLoading: successLoading ?? this.successLoading,
      message: message ?? this.message,
    );
  }
}
