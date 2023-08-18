import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/home/ui/post_list_widget.dart';
import 'package:flutter_social_media_app/features/home/ui/visit_profile_screen.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/post_bloc/post_bloc.dart';
import 'package:flutter_social_media_app/utiles/widgets/animated_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? lastPostId = null;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(AllPostsLoadEvent());

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      BlocProvider.of<PostBloc>(context).add(AllPostsLoadEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtherProfileBloc, OtherProfileState>(
      listener: (context, state) {
        if (state is LoadedOtherUserDataState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VisitProfile(userData: state.userdata)));
        }
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case AllpostsLoadingState:
              return AnimatedLoader();
            case AllpostsLoadedState:
              final loadedState = state as AllpostsLoadedState;

              return Container(
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: loadedState.allPosts.length,
                        itemBuilder: (context, index) {
                          return PostTileWidget(
                              postData: loadedState.allPosts[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            default:
              return AnimatedLoader();
          }
        },
      ),
    );
  }
}
