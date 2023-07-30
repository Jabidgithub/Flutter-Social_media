part of 'allposts_bloc.dart';

abstract class AllpostsState extends Equatable {
  const AllpostsState();

  @override
  List<Object> get props => [];
}

class AllpostsInitial extends AllpostsState {}

class AllpostsLoadingState extends AllpostsState {}

class AllpostsLoadedState extends AllpostsState {
  final List<Post> allPosts;

  const AllpostsLoadedState({required this.allPosts});

  @override
  List<Object> get props => [allPosts];
}

class AllpostsLoadErrorState extends AllpostsState {}
