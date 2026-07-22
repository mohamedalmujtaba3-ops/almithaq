import 'dart:io';
import 'package:image_picker/image_picker.dart';


imageUploadCamera() async {

  final XFile? file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90);
  if (file != null) {
    return File(file.path);
  } else {
    return null;
  }

}




imageUploadGallery() async {

  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }

}