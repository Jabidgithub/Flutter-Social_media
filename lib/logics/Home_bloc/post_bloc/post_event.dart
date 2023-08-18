part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class AllPostsLoadEvent extends PostEvent {
  const AllPostsLoadEvent();
}

class LoadUsersPostsEvent extends PostEvent {
  final String? userAccessId;

  const LoadUsersPostsEvent(this.userAccessId);
}

class CreatePostEvent extends PostEvent {
  final String title;
  final String description;
  final List<File> pictures;

  const CreatePostEvent({
    required this.title,
    required this.description,
    required this.pictures,
  });

  @override
  List<Object> get props => [title, description, pictures];
}

class DeletePostEvent extends PostEvent {
  final String postId;

  const DeletePostEvent({required this.postId});
}
