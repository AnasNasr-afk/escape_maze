import 'package:flutter/material.dart';
import 'maze_screen.dart';

void main() => runApp(MazeApp());

class MazeApp extends StatelessWidget {
  const MazeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MazeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
