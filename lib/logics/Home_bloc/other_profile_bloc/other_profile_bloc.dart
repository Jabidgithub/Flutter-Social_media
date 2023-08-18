import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';

part 'other_profile_event.dart';
part 'other_profile_state.dart';

class OtherProfileBloc extends Bloc<OtherProfileEvent, OtherProfileState> {
  final HomeRepository homeRepository;
  OtherProfileBloc(this.homeRepository) : super(OtherProfileInitial()) {
    on<LoadOtherUserDataEvent>(_loadOtherUserDataEvent);
  }

  FutureOr<UserData?> _loadOtherUserDataEvent(
      LoadOtherUserDataEvent event, Emitter<OtherProfileState> emit) async {
    emit(LoadingOtherUserDataState());

    try {
      final UserData? loadedData =
          await homeRepository.finedUser(event.postUserId);
      if (loadedData != null) {
        emit(LoadedOtherUserDataState(userdata: loadedData));
      } else {
        throw Exception("Loading user Data failed");
      }
    } catch (e) {
      emit(LoadingErrorOtherUserDataState(errorMessage: "User Data $e"));
    }
    return null;
  }
}
