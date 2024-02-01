import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
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
      child: TextButton.icon(
        onPressed: _takeImage,
        icon: const Icon(Icons.camera),
        label: const Text("Take Picture"),
      ),
    );
  }

  File? _selectedImage;
  void _takeImage() async {
    final imagePicker = ImagePicker();
    final XFile? pickImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickImage == null) {
      return;
    }
    _selectedImage = File(pickImage.path);
  }
}