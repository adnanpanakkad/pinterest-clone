import 'package:aifer_task/controller/image_controler.dart';
import 'package:aifer_task/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCard extends StatelessWidget {
  final UnsplashImage images;

  const ImageCard({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final UnsplashController controller = Get.put(UnsplashController());

    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              images.imageUrl,
              fit: BoxFit.fitHeight,
              height: images.height / 20,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    images.altDescription ?? 'no description',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                  onPressed: () async {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
