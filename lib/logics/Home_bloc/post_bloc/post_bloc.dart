import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/features/home/models/post_model.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final HomeRepository homeRepository;
  PostBloc(this.homeRepository) : super(PostInitial()) {
    on<AllPostsLoadEvent>(allPostsLoadEvent);
    on<LoadUsersPostsEvent>(loadUsersPostsEvent);
    on<CreatePostEvent>(_createPostEvent);
    on<DeletePostEvent>(_deletePostEvent);
  }

  FutureOr<void> allPostsLoadEvent(
      AllPostsLoadEvent event, Emitter<PostState> emit) async {
    emit(AllpostsLoadingState());

    try {
      final List<PostModel> allPosts = await homeRepository.getAllPosts();
      print("AllPost $allPosts");

      emit(AllpostsLoadedState(allPosts: allPosts));
    } catch (e) {
      emit(AllpostsLoadErrorState(
          errorMessage: 'Error in loading all posts $e'));
    }
  }

  FutureOr<void> loadUsersPostsEvent(
      LoadUsersPostsEvent event, Emitter<PostState> emit) async {
    emit(usersAllpostsLoadingState());
    try {
      final List<PostModel> allPosts =
          await homeRepository.getUserPosts(event.userAccessId);
      emit(usersallpostsLoadedState(allPosts: allPosts));
    } catch (e) {
      emit(usersallpostsLoadErrorState(
          errorMessage: "Error in loading users all post $e"));
    }
  }

  FutureOr<void> _createPostEvent(
      CreatePostEvent event, Emitter<PostState> emit) async {
    emit(CreateingPostState());
    try {
      final bool isPostCreated = await homeRepository.createPost(
          event.title, event.description, event.pictures);

      if (isPostCreated == true) {
        emit(CreatedPostState());
      }
    } catch (e) {
      emit(CreatingPostErrorState(errorMessage: 'Error in Creating post $e'));
    }
  }

  FutureOr<void> _deletePostEvent(
      DeletePostEvent event, Emitter<PostState> emit) async {
    emit(DeletingPostState());
    try {
      final bool isdeleted = await homeRepository.deletePost(event.postId);
      if (isdeleted == true) {
        emit(DeletedPostState());
      }
    } catch (e) {
      emit(DeletingErrorPostState(errorMessage: "Deleeting Post Error $e"));
    }
  }
}
