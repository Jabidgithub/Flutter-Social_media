part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeUserDataLoadingState extends HomeState {}

class HomeUserDataLoadedState extends HomeState {
  final UserData userData;

  const HomeUserDataLoadedState({required this.userData});
  @override
  List<Object> get props => [userData];
}

class HomeUserDataLoadingErrorState extends HomeState {
  final String errorMessage;

  const HomeUserDataLoadingErrorState({required this.errorMessage});

  List<Object> get props => [errorMessage];
}
