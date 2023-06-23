part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticatedState extends AuthState {
  final String username;

  const AuthenticatedState({required this.username});
  @override
  List<Object> get props => [username];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}
