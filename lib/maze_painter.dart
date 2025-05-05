import 'package:flutter/material.dart';
import 'package:escape_maze/maze_generator.dart';
import 'cell.dart';

class MazePainter extends CustomPainter {
  final MazeGenerator generator;

  MazePainter(this.generator);

  @override
  void paint(Canvas canvas, Size size) {
    double cellWidth = size.width / generator.width;
    double cellHeight = size.height / generator.height;

    final wallPaint = Paint()..color = Colors.black;
    final pathPaint = Paint()..color = Colors.white;
    final currentPaint = Paint()..color = Colors.green;
    final startPaint = Paint()..color = Colors.blue;
    final endPaint = Paint()..color = Colors.orange;
    final frontPaint = Paint()..color = Colors.red;  // Paint for the front cell

    for (int y = 0; y < generator.height; y++) {
      for (int x = 0; x < generator.width; x++) {
        Cell cell = generator.grid[y][x];
        Rect rect = Rect.fromLTWH(x * cellWidth, y * cellHeight, cellWidth, cellHeight);

        if (cell.isWall) {
          canvas.drawRect(rect, wallPaint);
        } else if (x == 1 && y == 1) {
          canvas.drawRect(rect, startPaint);
        } else if (x == generator.width - 2 && y == generator.height - 2) {
          canvas.drawRect(rect, endPaint);
        } else if (cell == generator.frontCell) {  // Check if it's the front cell
          canvas.drawRect(rect, frontPaint);
        } else if (cell.isCurrent) {
          canvas.drawRect(rect, currentPaint);
        } else {
          canvas.drawRect(rect, pathPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
