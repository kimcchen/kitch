import 'package:auth_practice/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 390,
              height: 85,
              color: Colors.deepOrangeAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.close,
                    size: 50,
                  ),
                  SizedBox(
                    width: 65,
                  ),
                  Text(
                    'New Post',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: 200,
              height: 200,
              child: Image.asset('images/undraw_cooking_lyxy.png'),
            ),
            SizedBox(
              height: 50,
            ),
            TextFieldInput(
                textEditingController: titleController,
                hintText: 'Title',
                textInputType: TextInputType.text),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: TextFieldInput(
                  textEditingController: captionController,
                  hintText: 'Caption',
                  textInputType: TextInputType.text),
            )
          ],
        ),
      ),
    ));
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
