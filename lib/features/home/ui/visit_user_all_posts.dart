import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/home/ui/visit_users_post_tile_widget.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/post_bloc/post_bloc.dart';
import 'package:flutter_social_media_app/utiles/widgets/animated_loading.dart';

class VisitUsersAllPosts extends StatefulWidget {
  final String? userAccessId;
  const VisitUsersAllPosts({
    super.key,
    this.userAccessId,
  });

  @override
  State<VisitUsersAllPosts> createState() => _VisitUsersAllPostsState();
}

class _VisitUsersAllPostsState extends State<VisitUsersAllPosts> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PostBloc>(context)
        .add(LoadUsersPostsEvent(widget.userAccessId));
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
      BlocProvider.of<PostBloc>(context)
          .add(LoadUsersPostsEvent(widget.userAccessId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.redAccent),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case usersAllpostsLoadingState:
              return AnimatedLoader();
            case usersallpostsLoadedState:
              final loadedState = state as usersallpostsLoadedState;
              return Container(
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: loadedState.allPosts.length,
                        itemBuilder: (context, index) {
                          return VisitUsersPostTileWidget(
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
