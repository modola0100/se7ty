class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthstate extends AuthState {}

class SuccesAuthState extends AuthState {
  final String? role;
  SuccesAuthState({this.role});
}

class ErrorAuthState extends AuthState {
  final String? error;
  ErrorAuthState(this.error);
}
