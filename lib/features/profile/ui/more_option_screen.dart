import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:flutter_social_media_app/logics/Auth_bloc/bloc_login/login_bloc.dart';
import 'package:flutter_social_media_app/utiles/widgets/animated_loading.dart';

class MoreOptions extends StatefulWidget {
  final UserData userData;
  const MoreOptions({super.key, required this.userData});

  @override
  State<MoreOptions> createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "${widget.userData.name}",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.redAccent),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("${widget.userData.avatar}"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.userData.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "to Change name click edit icon ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const Icon(Icons.edit_document),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.my_location_rounded),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.userData.location}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "to Change location click edit icon ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const Icon(Icons.edit_document),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.userData.phone}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "to Change Number click edit icon ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const Icon(Icons.edit_document),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.male_outlined),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.userData.gender}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "to Change Gander click edit icon ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const Icon(Icons.edit_document),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LogoutDoneState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (Route<dynamic> route) => false,
                  );
                } else if (state is LoginErrorState) {
                  print("${state.errorMessage}");
                }
              },
              builder: (context, state) {
                if (state is LogoutLoadingState) {
                  return const Center(
                    child: AnimatedLoader(),
                  );
                }
                return InkWell(
                  onTap: () async {
                    BlocProvider.of<LoginBloc>(context).add(LogOutEvent());
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                        child: Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is DeleteDoneState) {
                  print("Deleted Reached");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (Route<dynamic> route) => false,
                  );
                } else if (state is DeleteErrorState) {
                  print("${state.errorMessage}");
                }
              },
              builder: (context, state) {
                if (state is DeleteLoadingState) {
                  return const Center(
                    child: AnimatedLoader(),
                  );
                }
                return InkWell(
                  onTap: () async {
                    BlocProvider.of<LoginBloc>(context)
                        .add(DeleteAccountEvent());
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                        child: Text(
                      "Delete User",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
