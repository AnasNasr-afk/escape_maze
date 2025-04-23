import 'dart:async';
import 'package:flutter/material.dart';
import 'maze_generator.dart';
import 'maze_painter.dart';

class MazeScreen extends StatefulWidget {
  const MazeScreen({super.key});

  @override
  State<MazeScreen> createState() => _MazeScreenState();
}

class _MazeScreenState extends State<MazeScreen> {
  late PrimMaze maze;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    maze = PrimMaze(41, 41);
  }

  void startAnimation() {
    _timer?.cancel();
    maze = PrimMaze(41, 41);
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      bool hasNext = maze.step();
      setState(() {});
      if (!hasNext) timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Prim's Maze Generator",
          style: TextStyle(
            color: Colors.white
          ),

        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: CustomPaint(
              painter: MazePainter(maze: maze, cellSize: 10),
              size: Size(maze.width * 10.0, maze.height * 10.0),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: startAnimation,
        icon: Icon(Icons.play_arrow),
        label: Text('Start'),
      ),
    );
  }
}
