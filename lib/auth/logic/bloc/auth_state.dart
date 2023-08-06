part of 'auth_bloc.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final bool errorLoading;
  final bool successLoading;

  final bool isCheckingAuthState;
  final bool errorCheckingAuthState;
  final bool successCheckingAuthState;

  final String? message;
  AuthState({
    this.user,
    this.isLoading = false,
    this.errorLoading = false,
    this.successLoading = false,
    this.message,
    //
    this.isCheckingAuthState = false,
    this.errorCheckingAuthState = false,
    this.successCheckingAuthState = false,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    bool? errorLoading,
    bool? successLoading,
    bool? isCheckingAuthState,
    bool? errorCheckingAuthState,
    bool? successCheckingAuthState,
    String? message,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorLoading: errorLoading ?? this.errorLoading,
      successLoading: successLoading ?? this.successLoading,
      isCheckingAuthState: isCheckingAuthState ?? this.isCheckingAuthState,
      errorCheckingAuthState:
          errorCheckingAuthState ?? this.errorCheckingAuthState,
      successCheckingAuthState:
          successCheckingAuthState ?? this.successCheckingAuthState,
      message: message ?? this.message,
    );
  }
}
