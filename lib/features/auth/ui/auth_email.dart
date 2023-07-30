import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_social_media_app/features/auth/ui/auth_password.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:flutter_social_media_app/utiles/widgets/text_input_filed.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthEmail extends StatefulWidget {
  const AuthEmail({super.key});

  @override
  State<AuthEmail> createState() => _AuthEmailState();
}

class _AuthEmailState extends State<AuthEmail> {
  final TextEditingController _emailController = TextEditingController();

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
            SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset('assets/svgs/auth_svgs/auth_email.svg'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
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
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(40),
              child: TextInputField(
                controller: _emailController,
                icon: Icons.email,
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationResult && state.info == 'success') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthPassword(
                        email: _emailController.text,
                        userStatus: state.user,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthenticationLoading) {
                  return Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(CheckEmailEvent(email: _emailController.text));
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
