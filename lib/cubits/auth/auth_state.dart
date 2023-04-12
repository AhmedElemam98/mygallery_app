part of 'auth_cubit.dart';

abstract class AuthState {
  final bool isLoading;
  final String token;
  const AuthState({this.isLoading = false, this.token = ''});
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  AuthLoading() : super(isLoading: true);
}

class AuthLoggedIn extends AuthState {
  final User user;
  AuthLoggedIn(this.user) : super(token: user.token!);
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
