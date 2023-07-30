import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String? image;
  final storageRef = FirebaseStorage.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Screen'),
      ),
      body: image == null
          ? const SizedBox()
          : Center(
              child: Image(image: NetworkImage(image.toString())),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imageUrl = await storageRef
              .child(
                  "images/358438503_621026446672901_9057544623071049694_n.jpg")
              .getDownloadURL();
          setState(() {
            image = imageUrl;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
