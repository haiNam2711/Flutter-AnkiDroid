import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../firebase/cloud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

// ignore: must_be_immutable
class ImageEditor extends StatefulWidget {
  Function() changeState;
  Cloud cloud;
  String type;
  String cardName;

  ImageEditor(
      {Key? key,
      required this.changeState,
      required this.cloud,
      required this.cardName,
      required this.type})
      : super(key: key);

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  File? image;
  final picker = ImagePicker();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          key: const Key('ArrowBackIconButton'),
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: const Text(
            'Add image',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          IconButton(
            key: const Key('CheckIconButton'),
            onPressed: () {
              saveImage();
            },
            icon: const Icon(
              Icons.check,
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Flexible(
                child: image != null
                    ? Image.file(image!)
                    : const Text('No image')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                backgroundColor: Colors.grey,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Gallery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              onPressed: () {
                getImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  Future<void> saveImage() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    print(
        join(documentDirectory.path, '${widget.cardName}/${widget.type}.png'));
    image?.copySync(
        join(documentDirectory.path, '${widget.cardName}/${widget.type}.png'));
  }
}
