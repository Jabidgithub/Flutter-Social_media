import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';

part 'check_user_event.dart';
part 'check_user_state.dart';

class CheckUserBloc extends Bloc<CheckUserEvent, CheckUserState> {
  final HomeRepository homeRepository;
  CheckUserBloc(this.homeRepository) : super(CheckUserInitial()) {
    on<CheckUserExistEvent>(_checkUserExistEvent);
  }

  FutureOr<void> _checkUserExistEvent(
      CheckUserExistEvent event, Emitter<CheckUserState> emit) async {
    emit(CheckingUsersExistenceState());
    try {
      final String? accessToken = await homeRepository.getAccessToken();
      final String? accessId = await homeRepository.getAccessId();
      final UserData? userData =
          await homeRepository.getUserDataFromSharedPreferences();

      print(
          "AccessToken: $accessToken , AccessId: $accessId , UserData: $userData ");

      if (accessId != null && accessToken != null && userData != null) {
        print("TRUE Love");
        emit(const CheckUserExistState(UserExist: true));
      } else {
        print("False Love");
        emit(const CheckUserExistState(UserExist: false));
      }
    } catch (e) {
      emit(CheckUserErrorState(errorMessage: 'Error Occured $e'));
    }
  }
}
