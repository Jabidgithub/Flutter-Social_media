import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/home/models/post_model.dart';
import 'package:flutter_social_media_app/features/home/repos/home_repository.dart';

part 'allposts_event.dart';
part 'allposts_state.dart';

class AllpostsBloc extends Bloc<AllpostsEvent, AllpostsState> {
  final HomeRepository homeRepository;
  AllpostsBloc(this.homeRepository) : super(AllpostsInitial()) {
    on<AllPostsLoadEvent>(allPostsLoadEvent);
  }

  FutureOr<void> allPostsLoadEvent(
      AllPostsLoadEvent event, Emitter<AllpostsState> emit) async {
    emit(AllpostsLoadingState());

    try {
      final List<Post> allPosts = await homeRepository.getAllPosts();

      emit(AllpostsLoadedState(allPosts: allPosts));
    } catch (e) {
      emit(AllpostsLoadErrorState());
    }
  }
}
