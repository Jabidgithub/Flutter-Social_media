part of 'check_user_bloc.dart';

abstract class CheckUserState extends Equatable {
  const CheckUserState();

  @override
  List<Object> get props => [];
}

class CheckUserInitial extends CheckUserState {}

class CheckingUsersExistenceState extends CheckUserState {}

class CheckUserExistState extends CheckUserState {
  final bool UserExist;

  const CheckUserExistState({required this.UserExist});
  @override
  List<Object> get props => [UserExist];
}

class CheckUserErrorState extends CheckUserState {
  final String errorMessage;

  const CheckUserErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
