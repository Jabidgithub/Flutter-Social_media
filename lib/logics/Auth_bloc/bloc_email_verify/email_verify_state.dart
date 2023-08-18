part of 'email_verify_bloc.dart';

abstract class EmailVerifyState extends Equatable {
  const EmailVerifyState();

  @override
  List<Object> get props => [];
}

class EmailVerifyInitial extends EmailVerifyState {}

class EmailCheckingState extends EmailVerifyState {}

class EmailCheckResultState extends EmailVerifyState {
  final String info;
  final String user;

  const EmailCheckResultState({required this.info, required this.user});
  @override
  List<Object> get props => [info, user];
}

class EmailCheckingErrorState extends EmailVerifyState {
  final String errorMessage;

  const EmailCheckingErrorState({required this.errorMessage});
}
