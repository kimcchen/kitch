import 'package:auth_practice/widgets/text_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // title: TextFormField(
        //   controller: searchController,
        //   decoration: const InputDecoration(labelText: 'Add/Search Friends'),
        //   onFieldSubmitted: (String_) {
        //     setState(() {
        //       isShowUsers = true;
        //     });
        //   },
        // ),
        title: Text('Need Friends?'),
        // title: TextFieldInput(
        //   textEditingController: searchController,
        //   hintText: 'Add/Search Friends',
        //   textInputType: TextInputType.text,
        //   maxLines: 1,
        //   width: width * .8,
        // ),
        // centerTitle: true,
      ),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: TextFieldInput(
      //     textEditingController: searchController,
      //     hintText: 'Add/Search Friends',
      //     textInputType: TextInputType.text,
      //     maxLines: 1,
      //     width: width * .8,
      //   ),
      // ),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(top: 20),
      //       child: Center(
      //         child: TextFieldInput(
      //           textEditingController: searchController,
      //           hintText: 'Add/Search Friends',
      //           textInputType: TextInputType.text,
      //           maxLines: 1,
      //           width: width * .8,
      //         ),
      //       ),
      //     ),
      //
      //   ],
      // ),
      bottomSheet: isShowUsers
          ? Container(
              height: height * .1,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isShowUsers = false;
                      searchController.clear();
                    });
                  },
                  child: Text(
                    'Search Friends',
                    style: TextStyle(color: Colors.black38),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[100],
                  ),
                ),
              ),
            )
          : Container(
              height: height * .1,
            ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
                        ),
                        radius: 18,
                      ),
                      title: Text(
                        (snapshot.data! as dynamic).docs[index]['username'],
                      ),
                    );
                  },
                );
              },
            )
          // : TextFormField(
          //     controller: searchController,
          //     decoration:
          //         const InputDecoration(labelText: 'Add/Search Friends'),
          //     onFieldSubmitted: (String_) {
          //       setState(() {
          //         isShowUsers = true;
          //       });
          //     },
          //   ),
          : Row(
              children: [
                TextFieldInput(
                  textEditingController: searchController,
                  hintText: 'Add/Search Friends',
                  textInputType: TextInputType.text,
                  maxLines: 1,
                  width: width * .88,
                ),
                Container(
                  width: width * .12,
                  height: height * .058,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isShowUsers = true;
                      });
                    },
                    child: Text(' '),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[100],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
