part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeScreenLoading extends HomeState {}

class HomeScreenLoaded extends HomeState {
  final UserData userData;

  const HomeScreenLoaded({required this.userData});

  @override
  List<Object> get props => [userData];
}

class HomeScreenLoadingError extends HomeState {}
