import 'package:aifer_task/controller/image_controler.dart';
import 'package:aifer_task/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aifer_task/widgets/home/appbar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the UnsplashController using GetX dependency injection
    final UnsplashController controller = Get.put(UnsplashController());

    // Fetch images when the widget is built
    controller.fetchImages();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const HomeAppbar(), // The custom app bar widget
            Expanded(
              child: Obx(() {
                // Display loading spinner when images are being fetched
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // If images are loaded, display them in a StaggeredGridView
                if (controller.images.isEmpty) {
                  return const Center(child: Text("No images found"));
                }

                return SingleChildScrollView(
                  // Make the entire content scrollable
                  child: StaggeredGrid.count(
                    crossAxisCount: 2, // Number of columns
                    children: List.generate(
                      controller.images.length,
                      (index) {
                        final image = controller.images[index];
                        return buildCard(
                            image); // Pass the image data to the card builder
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Card builder to display each image
Widget buildCard(UnsplashImage image) {
  return Card(
    color: Colors.grey,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image.imageUrl,
            fit: BoxFit.fill,
            height: 200, // Adjust height as needed
            width: double.infinity,
          ),
        ),
      ],
    ),
  );
}
