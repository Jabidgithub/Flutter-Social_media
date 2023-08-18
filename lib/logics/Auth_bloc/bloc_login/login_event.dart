part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
/*------------------------------------------------------------*/

class FetchUserDataEvent extends LoginEvent {}
/*------------------------------------------------------------*/

class SignUpButtonPressedEvent extends LoginEvent {
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
/*------------------------------------------------------------*/

class LogOutEvent extends LoginEvent {}

/*------------------------------------------------------------*/

class DeleteAccountEvent extends LoginEvent {}
