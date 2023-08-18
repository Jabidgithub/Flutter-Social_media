part of 'email_verify_bloc.dart';

abstract class EmailVerifyEvent extends Equatable {
  const EmailVerifyEvent();

  @override
  List<Object> get props => [];
}

class EmailVerifyingEvent extends EmailVerifyEvent {
  final String email;

  const EmailVerifyingEvent({required this.email});
}
