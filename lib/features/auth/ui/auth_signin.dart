import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/home/ui/home_screen.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:flutter_social_media_app/utiles/widgets/text_input_filed.dart';

class AuthSignIn extends StatefulWidget {
  const AuthSignIn({super.key});

  @override
  State<AuthSignIn> createState() => _AuthSignInState();
}

class _AuthSignInState extends State<AuthSignIn>
    with SingleTickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      color: AppColors.primaryAuthColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 96, 161, 222),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage('assets/imgs/avatar.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
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
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
          ),
        ],
      ),
    );
  }
}
