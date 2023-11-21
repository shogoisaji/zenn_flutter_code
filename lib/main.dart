import 'package:flutter/material.dart';
import 'package:zenn_flutter_code/20231119render/rendering_sample.dart';
import 'package:zenn_flutter_code/20231121draggable_range/draggable_range.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DraggableRange(),
    );
  }
}
