import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:flutter_social_media_app/features/profile/repos/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<CheckUserExistEvent>(checkUserExistEventToState);
  }

  Future<void> checkUserExistEventToState(
      CheckUserExistEvent event, Emitter<ProfileState> emit) async {
    emit(UserCheckingState());
    try {
      final accessId = await profileRepository.getAccessId();
      final accessToken = await profileRepository.getAccessToken();

      if (accessId != null && accessToken != null) {
        await profileRepository.getUserData();
        emit(UserCurrentState(userExist: true));
      } else {
        emit(UserCurrentState(userExist: false));
      }
    } catch (e) {
      emit(UserDataError());
    }
  }
}
