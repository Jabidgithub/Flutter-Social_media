part of 'other_profile_bloc.dart';

abstract class OtherProfileState extends Equatable {
  const OtherProfileState();
  
  @override
  List<Object> get props => [];
}

class OtherProfileInitial extends OtherProfileState {}



class LoadingOtherUserDataState extends OtherProfileState {}

class LoadedOtherUserDataState extends OtherProfileState {
  final UserData userdata;

  const LoadedOtherUserDataState({required this.userdata});
  @override
  List<Object> get props => [userdata];
}

class LoadingErrorOtherUserDataState extends OtherProfileState {
  final String errorMessage;

  const LoadingErrorOtherUserDataState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
