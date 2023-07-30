part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CheckEmailEvent extends AuthenticationEvent {
  final String email;
  const CheckEmailEvent({
    required this.email,
  });
  @override
  List<Object> get props => [email];
}

class FetchUserDataEvent extends AuthenticationEvent {}

class LoginButtonPressedEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginButtonPressedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpButtonPressedEvent extends AuthenticationEvent {
  final String name;
  final String location;
  final String phone;
  final String gender;
  final File profilePic;
  const SignUpButtonPressedEvent({
    required this.name,
    required this.location,
    required this.phone,
    required this.gender,
    required this.profilePic,
  });

  @override
  List<Object> get props => [name, location, phone, gender, profilePic];
}
