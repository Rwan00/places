import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File image) onSelectedImage;
  const ImageInput({required this.onSelectedImage, super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takeImage() async {
    /*final imagePicker = ImagePicker();
    final XFile? pickImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickImage.path);
    });
    widget.onSelectedImage(_selectedImage!);*/
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takeImage,
      icon: const Icon(Icons.camera),
      label: const Text("Take Picture"),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takeImage,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
