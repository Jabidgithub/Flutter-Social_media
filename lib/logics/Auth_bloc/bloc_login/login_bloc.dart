import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/repositories/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  LoginBloc(this.authenticationRepository) : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
    on<FetchUserDataEvent>(fetchUserDataEvent);
    on<SignUpButtonPressedEvent>(signUpButtonPressedEvent);
    on<LogOutEvent>(logOutEvent);
    on<DeleteAccountEvent>(deleteAccountEvent);
  }

  FutureOr<void> loginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      final response = await authenticationRepository.loginFunction(
          event.email, event.password);
      print("Response: ${response.toString()}");
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(errorMessage: 'Error in login $e'));
    }
  }

  FutureOr<void> fetchUserDataEvent(
      FetchUserDataEvent event, Emitter<LoginState> emit) async {
    emit(LoadingUserDataState());
    try {
      final userData = await authenticationRepository.getUserData();
      if (userData != null) {
        emit(LoadedUserDataState());
      }
    } catch (e) {
      emit(LoadingUserDataErrorState(
          errorMessage: 'Error in Loading User Data $e'));
    }
  }

  FutureOr<void> signUpButtonPressedEvent(
      SignUpButtonPressedEvent event, Emitter<LoginState> emit) async {
    emit(SignUpLoadingState());
    try {
      final response = await authenticationRepository.signUpFunction(event.name,
          event.location, event.phone, event.gender, event.profilePic);

      emit(SignUpSuccessState(responseData: response));
    } catch (e) {
      emit(SignUpFailureState(errorMessage: 'Error in SignUp $e'));
    }
  }

  FutureOr<void> logOutEvent(
      LogOutEvent event, Emitter<LoginState> emit) async {
    emit(LogoutLoadingState());

    try {
      final response = await authenticationRepository.logout();
      if (response != false) {
        emit(LogoutDoneState());
      }
    } catch (e) {
      emit(LogoutErrorState(errorMessage: "Error Logout $e"));
    }
  }

  FutureOr<void> deleteAccountEvent(
      DeleteAccountEvent event, Emitter<LoginState> emit) async {
    emit(DeleteLoadingState());
    try {
      final response = await authenticationRepository.deleteUser();
      if (response == true) {
        emit(DeleteDoneState());
      }
    } catch (e) {
      emit(DeleteErrorState(errorMessage: "Error Deleting Users $e"));
    }
  }
}
