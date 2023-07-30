part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserData userData;

  const ProfileLoadedState(this.userData);

  @override
  List<Object> get props => [userData];
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  const ProfileErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class UserCheckingState extends ProfileState {}

class UserCurrentState extends UserCheckingState {
  final bool userExist;
  UserCurrentState({required this.userExist});
  @override
  List<Object> get props => [userExist];
}

class UserDataError extends UserCheckingState {}
