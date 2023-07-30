import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_social_media_app/features/auth/repos/authentication_repository.dart';
import 'package:flutter_social_media_app/features/home/logic/bloc/allposts_bloc.dart';
import 'package:flutter_social_media_app/features/home/logic/bloc/home_bloc.dart';
import 'package:flutter_social_media_app/features/home/repos/home_repository.dart';
import 'package:flutter_social_media_app/features/home/ui/home_screen.dart';
import 'package:flutter_social_media_app/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_social_media_app/features/profile/repos/profile_repository.dart';
import 'package:flutter_social_media_app/utiles/my_bloc_observer.dart';
import 'package:flutter_social_media_app/utiles/widgets/animated_loading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'features/auth/ui/auth_liquid_screens.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(AuthenticationRepository()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(ProfileRepository()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(HomeRepository()),
        ),
        BlocProvider(
          create: (context) => AllpostsBloc(HomeRepository()),
        ),
      ],
      child: MaterialApp(
        home: Builder(builder: (context) {
          return FutureBuilder(
            future: checkUserExist(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.hexagonDots(
                    color: Colors.red,
                    size: 40,
                  ),
                );
              } else {
                return BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case UserCheckingState:
                        return const AnimatedLoader();

                      case UserCurrentState:
                        if ((state as UserCurrentState).userExist == true) {
                          return const HomeScreen();
                        } else if ((state as UserCurrentState).userExist ==
                            false) {
                          return const AuthScreen();
                        }
                      default:
                        return const AuthScreen();
                    }
                    // Add a default return statement to handle non-nullable return type
                    return const AuthScreen();
                  },
                );
              }
            },
          );
        }),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Future<void> checkUserExist(BuildContext context) async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating some asynchronous operation
    BlocProvider.of<ProfileBloc>(context).add(CheckUserExistEvent());
  }
}
