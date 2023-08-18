import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final HomeRepository homeRepository;
  LikeCubit(this.homeRepository) : super(LikeInitial());

  void reactionToggledFunc(String postId, String reactionType) async {
    try {
      await homeRepository
          .likeACertainPost(postId, reactionType)
          .whenComplete(() => emit(LikeToggleState()));
    } catch (e) {
      throw Exception("Liking Error $e");
    }
  }
}
