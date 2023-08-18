import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<HomeUserDataLoadingEvent>(homeUserDataLoadingEvent);
    
  }

  FutureOr<void> homeUserDataLoadingEvent(
      HomeUserDataLoadingEvent event, Emitter<HomeState> emit) async {
    emit(HomeUserDataLoadingState());

    try {
      final userData = await homeRepository.getUserDataFromSharedPreferences();
      if (userData != null) {
        emit(HomeUserDataLoadedState(userData: userData));
      }
    } catch (e) {
      emit(HomeUserDataLoadingErrorState(
          errorMessage: "Error in HomeUser Data Loading $e"));
    }
  }

}
