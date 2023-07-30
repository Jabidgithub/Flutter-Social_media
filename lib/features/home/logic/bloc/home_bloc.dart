import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/home/repos/home_repository.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<HomeLoadDataEvent>(_onHomeLoadDataEvent);
    
  }

  void _onHomeLoadDataEvent(
      HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeScreenLoading());
    try {
      final userData = await homeRepository.getUserDataFromSharedPreferences();
      if (userData != null) {
        emit(HomeScreenLoaded(userData: userData));
      } else {
        emit(HomeScreenLoadingError());
      }
    } catch (e) {
      emit(HomeScreenLoadingError());
    }
  }
}
