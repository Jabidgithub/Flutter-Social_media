import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_social_media_app/features/home/ui/home_screen.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:flutter_social_media_app/utiles/widgets/text_input_filed.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthSignUp extends StatefulWidget {
  const AuthSignUp({super.key});

  @override
  State<AuthSignUp> createState() => _AuthSignUpState();
}

class _AuthSignUpState extends State<AuthSignUp> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _selectedGender;
  File? _imageFile;
  bool _fetchingLocation = false;
  String? _location;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedImage!.path);
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _fetchingLocation = true;
    });

    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      String cityName = placemarks.first.locality ?? '';

      setState(() {
        _location = cityName;
        _fetchingLocation = false;
      });
    } else {
      _location = "Not Given";
      _fetchingLocation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
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
                      backgroundImage: (_imageFile != null)
                          ? FileImage(_imageFile!)
                          : AssetImage('assets/imgs/avatar.png')
                              as ImageProvider<Object>?,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        _selectImage();
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: _userNameController,
                labelText: "Username",
                icon: Icons.person,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: _phoneNumberController,
                labelText: "Phone Number",
                icon: Icons.phone,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  if (_fetchingLocation)
                    CircularProgressIndicator()
                  else if (_location != null)
                    Text(_location!)
                  else
                    ElevatedButton(
                      onPressed: _getCurrentLocation,
                      child: Text("Add Location"),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Gender',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(
                        () {
                          _selectedGender = value!;
                        },
                      );
                    },
                  ),
                  Text('Male'),
                  Radio(
                    value: 'female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  Text('Female'),
                  Radio(
                    value: 'other',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  Text('Other'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                if (state is SignUpSuccessState) {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(FetchUserDataEvent());
                } else if (state is SignUpFailureState) {
                  String errorMessage = 'SignUp Error. Please try again later.';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                    ),
                  );
                } else if (state is LoadedUserDataState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              }, builder: (context, state) {
                if (state is SignUpLoadingState) {
                  return Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          SignUpButtonPressedEvent(
                              name: _userNameController.text,
                              location: _location!,
                              phone: _phoneNumberController.text,
                              gender: _selectedGender!,
                              profilePic: _imageFile!));
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
                            "Sign Up",
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}
