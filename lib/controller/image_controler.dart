import 'dart:convert';
import 'package:aifer_task/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
}
