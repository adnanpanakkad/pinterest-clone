import 'package:aifer_task/controller/image_controler.dart';
import 'package:aifer_task/widgets/home/img_card.dart';
import 'package:aifer_task/widgets/home/shimmercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aifer_task/widgets/home/appbar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UnsplashController controller = Get.put(UnsplashController());

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: controller.fetchImages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerList();
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return Column(
                children: [
                  const HomeAppbar(),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const ShimmerList();
                      }

                      if (controller.images.isEmpty) {
                        return const Center(child: Text("No images found"));
                      }

                      return SingleChildScrollView(
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          children: List.generate(
                            controller.images.length,
                            (index) {
                              final image = controller.images[index];
                              return ImageCard(images: image);
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
