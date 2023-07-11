import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _postEditingController = TextEditingController();
  final int maxWordLimit = 225;
  String? errorText;

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
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                        IconButton(onPressed: () {}, icon: Icon(Icons.photo)),
                        Text(
                          "Add photo from Gallary",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt_outlined)),
                        Text(
                          "Add photo from Camera",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
