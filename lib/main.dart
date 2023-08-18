import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/logics/Auth_bloc/bloc_check_user/check_user_bloc.dart';
import 'package:flutter_social_media_app/features/home/ui/home_screen.dart';
import 'package:flutter_social_media_app/logics/Auth_bloc/bloc_email_verify/email_verify_bloc.dart';
import 'package:flutter_social_media_app/logics/Auth_bloc/bloc_login/login_bloc.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/post_bloc/post_bloc.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/profile_bloc/home_bloc.dart';
import 'package:flutter_social_media_app/logics/cubit/like_cubit/like_cubit.dart';
import 'package:flutter_social_media_app/repositories/authentication_repository.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';
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
          create: (context) => CheckUserBloc(HomeRepository()),
        ),
        BlocProvider(
            create: (context) => EmailVerifyBloc(AuthenticationRepository())),
        BlocProvider(
            create: (context) => LoginBloc(AuthenticationRepository())),
        BlocProvider(create: (context) => PostBloc(HomeRepository())),
        BlocProvider(create: (context) => HomeBloc(HomeRepository())),
        BlocProvider(create: (context) => OtherProfileBloc(HomeRepository())),
        BlocProvider(create: (context) => LikeCubit(HomeRepository())),
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
                return BlocBuilder<CheckUserBloc, CheckUserState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case CheckingUsersExistenceState:
                        return const AnimatedLoader();

                      case CheckUserExistState:
                        if ((state as CheckUserExistState).UserExist == true) {
                          return const HomeScreen();
                        } else if ((state as CheckUserExistState).UserExist ==
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
    BlocProvider.of<CheckUserBloc>(context).add(CheckUserExistEvent());
  }
}
