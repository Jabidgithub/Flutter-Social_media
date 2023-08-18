part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

/*-----------------------------------------------------*/
class AllpostsLoadingState extends PostState {}

class AllpostsLoadedState extends PostState {
  final List<PostModel> allPosts;

  const AllpostsLoadedState({required this.allPosts});

  @override
  List<Object> get props => [allPosts];
}

class AllpostsLoadErrorState extends PostState {
  final String errorMessage;

  const AllpostsLoadErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

/*-----------------------------------------------------*/

class usersAllpostsLoadingState extends PostState {}

class usersallpostsLoadedState extends PostState {
  final List<PostModel> allPosts;

  const usersallpostsLoadedState({required this.allPosts});

  @override
  List<Object> get props => [allPosts];
}

class usersallpostsLoadErrorState extends PostState {
  final String errorMessage;

  const usersallpostsLoadErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
/*-----------------------------------------------------*/

class CreateingPostState extends PostState {}

class CreatedPostState extends PostState {}

class CreatingPostErrorState extends PostState {
  final String errorMessage;

  const CreatingPostErrorState({required this.errorMessage});
}
/*-----------------------------------------------------*/

class DeletingPostState extends PostState {}

class DeletedPostState extends PostState {}

class DeletingErrorPostState extends PostState {
  final String errorMessage;

  const DeletingErrorPostState({required this.errorMessage});
}
