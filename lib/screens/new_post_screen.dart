import 'dart:typed_data';

import 'package:auth_practice/models/user.dart';
import 'package:auth_practice/providers/user_provider.dart';
import 'package:auth_practice/services/firestore_methods.dart';
import 'package:auth_practice/utils/utils.dart';
import 'package:auth_practice/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  Uint8List? _file;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  bool _isLoading = false;

  // void clearImage() {
  //   setState(() {
  //     _file == null;
  //     print('FILE WAS SET TO NULL');
  //   });
  // }

  void postImage(
    String uid,
    String username,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _titleController.text,
        _captionController.text,
        _file!,
        uid,
        username,
      );

      if (res == "success") {
        setState(() {
          _isLoading = false;
          _file == null;
        });
        showSnackBar(context, 'Posted!');
        Navigator.pop(context);

        // clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, res);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _file == null
        ? Scaffold(
            backgroundColor: Colors.amber,
            body: Center(
              child: IconButton(
                icon: const Icon(Icons.upload),
                onPressed: () => _selectImage(context),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      color: Colors.red[100],
                    ),
                    width: 390,
                    height: 100,
                    // color: Colors.red[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 65,
                        ),
                        Text(
                          'New Post',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  _isLoading ? const LinearProgressIndicator() : Container(),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            // image: NetworkImage(
                            //     'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1380&q=80'),
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //-----------------------------------------------------------------------------
                  // Container(
                  //   width: 200,
                  //   height: 200,
                  //   child: Image.asset('images/undraw_cooking_lyxy.png'),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldInput(
                    textEditingController: _titleController,
                    hintText: 'Title',
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    width: 300,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFieldInput(
                      textEditingController: _captionController,
                      hintText: 'Caption',
                      textInputType: TextInputType.text,
                      maxLines: 8,
                      width: 300,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 55),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => postImage(userProvider.getUser.uid,
                            userProvider.getUser.username),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text('Share'),
                            SizedBox(
                              width: 90,
                            ),
                            Icon(Icons.arrow_forward_ios_rounded),
                          ],
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
//    return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [Text('heleeee')],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
