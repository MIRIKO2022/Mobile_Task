import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home/home_screen/home_page.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<File> selectedImage = [];

  Future<void> imageSelector() async {
    final images = await imagePicker.pickMultiImage();
    if (images != null && mounted) {
      setState(() {
        selectedImage.addAll(
          images.map((xfile) => File(xfile.path)),
        );
      });
    }
  }

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController bodyCtrl  = TextEditingController();

  @override
  void dispose() {
    titleCtrl.dispose();
    bodyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          SizedBox(height: 30),
          selectedImage.isEmpty
              ? Container(
            height: 150,
            color: Colors.white30,
            child: IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: imageSelector,
            ),
          )
              : Row(
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.white30,
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: imageSelector,
                ),
              ),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width - 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: selectedImage.map((file) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.file(file, height: 100, width: 100, fit: BoxFit.cover),
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() => selectedImage.remove(file));
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(
              hintText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: bodyCtrl,
            minLines: 3,
            maxLines: 7,
            decoration: InputDecoration(
              hintText: "Body",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MyHomePage(
                Title: titleCtrl.text,
                Body: bodyCtrl.text,
                image: selectedImage,
              ),
            ),
          );
        },
      ),
    );
  }
}
