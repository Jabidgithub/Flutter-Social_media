import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/post_bloc/post_bloc.dart';
import 'package:flutter_social_media_app/utiles/widgets/animated_loading.dart';
import 'package:flutter_social_media_app/utiles/widgets/text_input_filed.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _postEditingController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final int maxWordLimit = 225;
  String? errorText;
  File? _imageFile;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedImage!.path);
    });
  }

  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'Text Area is empty';
    } else {
      List<String> words = text.split(' ');
      if (words.length == maxWordLimit) {
        return 'Reached the word limit of $maxWordLimit words';
      }
    }

    return null;
  }

  void onChange(String value) {
    setState(() {
      errorText =
          validateText(value); // Update errorText with the validated value
    });
  }

  @override
  void dispose() {
    _postEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Add Post Here",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              TextInputField(
                controller: _titleController,
                icon: Icons.chrome_reader_mode,
                labelText: 'Title',
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: _postEditingController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(maxWordLimit),
                    ],
                    onChanged: onChange,
                    decoration: InputDecoration(
                      labelText: 'Enter text (${maxWordLimit} words max)',
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      prefixIcon: const Icon(Icons.text_snippet),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    maxLines: 5,
                  ),
                  if (errorText != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorText!,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                _selectImage();
                              },
                              icon: Icon(Icons.photo)),
                          Text(
                            "Add photo from Gallary",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        child: (_imageFile != null)
                            ? Image.file(
                                _imageFile!,
                                fit: BoxFit
                                    .cover, // You can adjust the BoxFit based on your UI requirements
                              )
                            : Image.asset(
                                "assets/imgs/gallary.png",
                                fit: BoxFit
                                    .cover, // You can adjust the BoxFit based on your UI requirements
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<PostBloc, PostState>(
                    listener: (context, state) {
                      if (state is CreatedPostState) {
                        _postEditingController.clear();
                        _titleController.clear();
                        _imageFile = null;
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateingPostState) {
                        return AnimatedLoader();
                      } else {
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<PostBloc>(context).add(
                                CreatePostEvent(
                                    title: _titleController.text,
                                    description: _postEditingController.text,
                                    pictures: [_imageFile!]));
                          },
                          child: Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                "Post",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
