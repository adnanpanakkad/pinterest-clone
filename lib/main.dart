import 'package:aifer_task/widgets/home/bottombar.dart';
import 'package:aifer_task/view/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: BottombarScreens(),
      debugShowCheckedModeBanner: false,
    );
  }
}
