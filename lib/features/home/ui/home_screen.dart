import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/home/logic/bloc/home_bloc.dart';
import 'package:flutter_social_media_app/features/home/ui/notification_screen.dart';
import 'package:flutter_social_media_app/features/profile/ui/my_profile_screen.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:flutter_social_media_app/utiles/widgets/animated_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeLoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeScreenLoaded:
            final successState = state as HomeScreenLoaded;

            return Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  onTap: () => toNotificationPage(context),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.notifications_active,
                          color: Colors.grey[600],
                          size: 30,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 30,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                              "5",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                title: const Text(
                  "Orbit",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: () => toProfilePage(context, successState.userData),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage("${successState.userData.avatar}"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: navigationPages[_currentIndex],
              bottomNavigationBar: CustomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                iconSize: 25.0,
                selectedColor: Colors.redAccent,
                strokeColor: Colors.redAccent,
                unSelectedColor: Colors.grey,
                backgroundColor: Colors.white,
                borderRadius: const Radius.circular(40),
                items: [
                  CustomNavigationBarItem(
                    icon: const Icon(Icons.home),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(Icons.add),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(Icons.ondemand_video_rounded),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(Icons.message),
                  ),
                  CustomNavigationBarItem(
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              // drawer: ,
            );
          case HomeScreenLoading:
            return AnimatedLoader();
          default:
            return SizedBox();
        }
      },
    );
  }
}

toNotificationPage(context) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              NotificationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(-1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }));
}

toProfilePage(context, userdata) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MyProfile(
                userData: userdata,
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }));
}
