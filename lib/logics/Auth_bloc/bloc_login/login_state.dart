part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}
/*------------------------------------------------------------*/

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;

  const LoginErrorState({required this.errorMessage});
}

/*------------------------------------------------------------*/
class LoadingUserDataState extends LoginState {}

class LoadedUserDataState extends LoginState {}

class LoadingUserDataErrorState extends LoginState {
  final String errorMessage;

  const LoadingUserDataErrorState({required this.errorMessage});
}

/*------------------------------------------------------------*/

class SignUpLoadingState extends LoginState {}

class SignUpSuccessState extends LoginState {
  final String responseData;

  const SignUpSuccessState({
    required this.responseData,
  });

  @override
  List<Object> get props => [responseData];
}

class SignUpFailureState extends LoginState {
  final String errorMessage;

  const SignUpFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

/*------------------------------------------------------------*/

class LogoutLoadingState extends LoginState {}

class LogoutDoneState extends LoginState {}

class LogoutErrorState extends LoginState {
  final String errorMessage;

  const LogoutErrorState({required this.errorMessage});
}


/*------------------------------------------------------------*/

class DeleteLoadingState extends LoginState {}

class DeleteDoneState extends LoginState {}

class DeleteErrorState extends LoginState {
  final String errorMessage;

  const DeleteErrorState({required this.errorMessage});
}
