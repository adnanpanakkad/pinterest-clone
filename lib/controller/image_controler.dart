import 'dart:convert';
import 'dart:io';
import 'package:aifer_task/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class UnsplashController extends GetxController {
  final String ApiUrl =
      "https://api.unsplash.com/photos?client_id=r0KxJf8u94vRxQ_swoFH-RqqCRpJVBfCLoSIflqRbMY";
  var images = <UnsplashImage>[].obs;
  var isLoading = false.obs;

  // Fetch images from the API
  Future<void> fetchImages() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse(ApiUrl));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        images.value =
            data.map((json) => UnsplashImage.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to load images: ${response.reasonPhrase}",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveImage(BuildContext context, String downloadUrl) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Download image
      final http.Response response = await http.get(Uri.parse(downloadUrl));
      final dir = await getTemporaryDirectory();
      // Create an image name
      var filename = '${dir.path}/image.png';
      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);
      if (finalPath != null) {
        message = 'Image saved to files';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      Get.snackbar(
        'Save Image',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
