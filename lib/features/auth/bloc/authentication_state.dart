part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationResult extends AuthenticationState {
  final String info;
  final String user;

  const AuthenticationResult({
    required this.info,
    required this.user,
  });

  @override
  List<Object> get props => [info, user];
}

class LogingLoadingState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {
  final String accessToken;

  const LoginSuccessState({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}

class LoginErrorState extends AuthenticationState {
  final String errorMessage;

  const LoginErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class SignUpLoadingState extends AuthenticationState {}

class SignUpSuccessState extends AuthenticationState {
  final String responseStatus;

  const SignUpSuccessState(this.responseStatus);
  @override
  List<Object> get props => [responseStatus];
}

class SignUpFailureState extends AuthenticationState {
  final String errorMessage;

  const SignUpFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class LoadingOldUserDataState extends AuthenticationState {}

class LoadedUserDataState extends AuthenticationState {}

class LoadingOldUserDataStateError extends AuthenticationState {}
