part of 'other_profile_bloc.dart';

abstract class OtherProfileEvent extends Equatable {
  const OtherProfileEvent();

  @override
  List<Object> get props => [];
}



class LoadOtherUserDataEvent extends OtherProfileEvent {
  final String postUserId;

  const LoadOtherUserDataEvent({required this.postUserId});

  @override
  List<Object> get props => [postUserId];
}
