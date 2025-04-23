import 'dart:math';
import 'package:flutter/material.dart';
import 'maze_generator.dart';

class MazePainter extends CustomPainter {
  final PrimMaze maze;
  final double cellSize;
  final Color wallColor;
  final Color pathColor;
  final Color highlightColor;

  MazePainter({
    required this.maze,
    this.cellSize = 10,
    this.wallColor = Colors.black,
    this.pathColor = Colors.white,
    this.highlightColor = Colors.red,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int x = 0; x < maze.width; x++) {
      for (int y = 0; y < maze.height; y++) {
        paint.color = maze.grid[x][y] ? pathColor : wallColor;
        canvas.drawRect(
          Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize),
          paint,
        );
      }
    }

    if (maze.currentFrontier != null) {
      paint.color = highlightColor;
      canvas.drawRect(
        Rect.fromLTWH(
          maze.currentFrontier!.x * cellSize,
          maze.currentFrontier!.y * cellSize,
          cellSize,
          cellSize,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MazePainter oldDelegate) {
    return true;
  }
}
