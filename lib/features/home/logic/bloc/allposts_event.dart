part of 'allposts_bloc.dart';

abstract class AllpostsEvent extends Equatable {
  const AllpostsEvent();

  @override
  List<Object> get props => [];
}

class AllPostsLoadEvent extends AllpostsEvent {}
