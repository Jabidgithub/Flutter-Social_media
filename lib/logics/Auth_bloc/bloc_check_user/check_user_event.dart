part of 'check_user_bloc.dart';

abstract class CheckUserEvent extends Equatable {
  const CheckUserEvent();

  @override
  List<Object> get props => [];
}

class CheckUserExistEvent extends CheckUserEvent {}
