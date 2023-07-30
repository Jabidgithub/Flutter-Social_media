import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_social_media_app/features/auth/ui/auth_email.dart';
import 'package:flutter_social_media_app/features/auth/ui/auth_signup.dart';
import 'package:flutter_social_media_app/features/home/ui/home_screen.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:flutter_social_media_app/utiles/widgets/text_input_filed.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthPassword extends StatefulWidget {
  final String email;
  final String userStatus;
  const AuthPassword(
      {super.key, required this.email, required this.userStatus});

  @override
  State<AuthPassword> createState() => _AuthPasswordState();
}

class _AuthPasswordState extends State<AuthPassword> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        color: AppColors.primaryAuthColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextInputField(
              controller: _passwordController,
              labelText: "Password",
              icon: Icons.lock,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (_, state) {
                if (state is LoginSuccessState && widget.userStatus == 'old') {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(FetchUserDataEvent());
                } else if (state is LoginSuccessState &&
                    widget.userStatus == 'new') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthSignUp(),
                    ),
                  );
                } else if (state is LoginErrorState) {
                  String errorMessage = 'Login. Please try again later.';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                    ),
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (Route<dynamic> route) => false,
                  );
                } else if (state is LoadedUserDataState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LogingLoadingState) {
                  return Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      print("Password: ${_passwordController.text} ");
                      print("Email: ${widget.email} ");

                      BlocProvider.of<AuthenticationBloc>(context).add(
                        LoginButtonPressedEvent(
                          email: widget.email,
                          password: _passwordController.text.trim(),
                        ),
                      );
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
                            "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
