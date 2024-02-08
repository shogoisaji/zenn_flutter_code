import 'package:flutter/material.dart';
import 'package:zenn_flutter_code/20231121draggable_range/draggable_range.dart';
import 'package:zenn_flutter_code/20231210spring_animation/spring_animation.dart';
import 'package:zenn_flutter_code/20231220glossy_button/glossy_button.dart';
import 'package:zenn_flutter_code/20240107calender/calender.dart';
import 'package:zenn_flutter_code/2024custom_paint/custom_paint.dart/custom_paint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimateWidget(),
    );
  }
}
