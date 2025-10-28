class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthstate extends AuthState {}

class SuccesAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String? error;
  ErrorAuthState(this.error);
}
