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
    return Scaffold(
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
              height: 25,
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
              textInputType: TextInputType.text,
              maxLines: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextFieldInput(
                textEditingController: captionController,
                hintText: 'Caption',
                textInputType: TextInputType.text,
                maxLines: 8,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 55),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: null,
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
