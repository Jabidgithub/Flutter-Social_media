import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/auth/repos/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc(this.authenticationRepository)
      : super(AuthenticationInitial()) {
    on<CheckEmailEvent>((event, emit) => _checkEmailEventToState(event, emit));

    on<LoginButtonPressedEvent>(
        (event, emit) => _loginButtonPressedEventToState(event, emit));

    on<SignUpButtonPressedEvent>(
        (event, emit) => _signUpButtonPressedEventToState(event, emit));

    on<FetchUserDataEvent>(fetchUserDataEventToState);
  }

  Future<void> fetchUserDataEventToState(
      FetchUserDataEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingOldUserDataState());

    try {
      final userdata = await authenticationRepository.getUserData();

      print("Loading User Data");
      if (userdata != null) {
        print("Loaded User Data");

        emit(LoadedUserDataState());
      }
    } catch (e) {
      print("Loading Failed User Data");

      emit(LoadingOldUserDataStateError());
    }
  }

  Future<void> _checkEmailEventToState(
      CheckEmailEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());

    try {
      final response = await authenticationRepository.verifyEmail(event.email);

      emit(AuthenticationResult(info: response.info, user: response.user));
    } catch (e) {
      // print('Check Email API error: $e');
      emit(const AuthenticationResult(info: 'error', user: ''));
    }
  }

  Future<void> _loginButtonPressedEventToState(
      LoginButtonPressedEvent event, Emitter<AuthenticationState> emit) async {
    emit(LogingLoadingState());

    try {
      final response = await authenticationRepository.loginFunction(
          event.email, event.password);
      print(response.toString());

      emit(LoginSuccessState(accessToken: response));
    } catch (e) {
      print(e.toString());
      // print('Login API error: $e');
      emit(const LoginErrorState(errorMessage: 'Login Error'));
    }
  }

  Future<void> _signUpButtonPressedEventToState(
      SignUpButtonPressedEvent event, Emitter<AuthenticationState> emit) async {
    emit(SignUpLoadingState());

    try {
      final response = await authenticationRepository.signUpFunction(event.name,
          event.location, event.phone, event.gender, event.profilePic);

      emit(SignUpSuccessState(response));
    } catch (e) {
      // print('Sign Up API error: $e');
      emit(const SignUpFailureState(errorMessage: 'SignUp Error'));
    }
  }
}
