import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:flutter_social_media_app/utiles/widgets/text_input_filed.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthEmail extends StatefulWidget {
  const AuthEmail({super.key});

  @override
  State<AuthEmail> createState() => _AuthEmailState();
}

class _AuthEmailState extends State<AuthEmail>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showText = false;
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 300).animate(
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
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColors.secondaryAuthColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 150,
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Visibility(
                  visible:
                      _animationController.status != AnimationStatus.dismissed,
                  child: SizedBox(
                    width: _animation.value,
                    height: _animation.value,
                    child: SvgPicture.asset(
                        'assets/svgs/auth_svgs/auth_email.svg'),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
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
                      "Orbit ",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Join to the Excellent",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _showText ? 1.0 : 0.0,
              child: Container(
                padding: const EdgeInsets.all(40),
                child: TextInputField(
                  controller: _emailController,
                  icon: Icons.email,
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _showText ? 1.0 : 0.0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    
                  },
                  borderRadius: BorderRadius.circular(10),
                  splashColor: AppColors.buttonColor.withOpacity(0.5),
                  child: Card(
                    color: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const SizedBox(
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
