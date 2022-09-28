import 'package:flutter/material.dart';

class AddScene extends StatefulWidget {
  const AddScene({Key? key}) : super(key: key);

  @override
  State<AddScene> createState() => _AddSceneState();
}

class _AddSceneState extends State<AddScene> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: const [
                Text(
                  'AnkiDroid',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '10 cards due.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.undo,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark_add,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
