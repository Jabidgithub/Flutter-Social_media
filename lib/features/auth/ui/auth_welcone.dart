import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthWelcome extends StatefulWidget {
  const AuthWelcome({super.key});

  @override
  State<AuthWelcome> createState() => _AuthWelcomeState();
}

class _AuthWelcomeState extends State<AuthWelcome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 350).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    Future.delayed(
        const Duration(
          milliseconds: 500,
        ), () {
      setState(() {
        _animationController.forward();
        _showText = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryAuthColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Visibility(
                visible:
                    _animationController.status != AnimationStatus.dismissed,
                child: Container(
                  width: _animation.value,
                  height: _animation.value,
                  child: SvgPicture.asset(
                      'assets/svgs/auth_svgs/auth_welcome.svg'),
                ),
              );
            },
          ),
          const SizedBox(
            height: 60,
          ),
          AnimatedOpacity(
            opacity: _showText ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Orbit",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
