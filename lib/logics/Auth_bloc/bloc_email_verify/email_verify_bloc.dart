import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/repositories/authentication_repository.dart';

part 'email_verify_event.dart';
part 'email_verify_state.dart';

class EmailVerifyBloc extends Bloc<EmailVerifyEvent, EmailVerifyState> {
  final AuthenticationRepository authenticationRepository;
  EmailVerifyBloc(this.authenticationRepository) : super(EmailVerifyInitial()) {
    on<EmailVerifyingEvent>(emailVerifyingEvent);
  }

  FutureOr<void> emailVerifyingEvent(
      EmailVerifyingEvent event, Emitter<EmailVerifyState> emit) async {
    emit(EmailCheckingState());
    try {
      final response = await authenticationRepository.verifyEmail(event.email);
      emit(EmailCheckResultState(info: response.info, user: response.user));
    } catch (e) {
      emit(EmailCheckingErrorState(errorMessage: "Email Error $e"));
    }
  }
}
