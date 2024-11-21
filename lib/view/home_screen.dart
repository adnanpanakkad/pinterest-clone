import 'package:aifer_task/widgets/home/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HomeAppbar(), // The custom app bar widget
            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                itemCount: items.length, // Match the count to the `items` list
                itemBuilder: (context, index) {
                  final item = items[index];
                  return buildCard(
                      item); // Pass the correct `item` to the card builder
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy data for staggered grid
final List<String> items = [
  "Short Item",
  "This is a longer item that spans more space",
  "Another short one",
  "This one is a bit longer but not too much",
  "Short again",
  "The longest item in the list to test the staggered layout",
];

// Staggered card builder
Widget buildCard(String item) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        item,
        style: const TextStyle(fontSize: 16),
      ),
    ),
  );
}
