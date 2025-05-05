import 'dart:math';
import 'cell.dart';

class MazeGenerator {
  final int width, height;
  final Random _random = Random();
  late List<List<Cell>> grid;
  List<Cell> frontier = [];
  Cell? frontCell;  // Track the front cell

  MazeGenerator(this.width, this.height) {
    grid = List.generate(
      height,
          (y) => List.generate(width, (x) => Cell(x: x, y: y)),
    );
  }

  void initialize() {
    int startX = _random.nextInt(width ~/ 2) * 2;
    int startY = _random.nextInt(height ~/ 2) * 2;
    grid[startY][startX].isWall = false;
    _addFrontiers(startX, startY);
    frontCell = grid[startY][startX];  // Set the starting cell as the front cell
  }

  void _addFrontiers(int x, int y) {
    const directions = [[2, 0], [-2, 0], [0, 2], [0, -2]];
    for (var dir in directions) {
      int nx = x + dir[0], ny = y + dir[1];
      if (_inBounds(nx, ny) && grid[ny][nx].isWall && !frontier.contains(grid[ny][nx])) {
        frontier.add(grid[ny][nx]);
      }
    }
  }

  bool step() {
    if (frontier.isEmpty) {
      return false;  // Finish when no more frontiers are left
    }

    final current = frontier.removeAt(_random.nextInt(frontier.length));
    current.isCurrent = true;  // Mark the current cell

    // Set the front cell to the newly chosen cell
    frontCell = current;

    final neighbors = _visitedNeighbors(current.x, current.y);
    if (neighbors.isNotEmpty) {
      final neighbor = neighbors[_random.nextInt(neighbors.length)];
      int wallX = (current.x + neighbor.x) ~/ 2;
      int wallY = (current.y + neighbor.y) ~/ 2;
      grid[current.y][current.x].isWall = false;
      grid[wallY][wallX].isWall = false;
      _addFrontiers(current.x, current.y);
    }

    current.isCurrent = false;
    return true;  // Keep generating steps
  }

  List<Cell> _visitedNeighbors(int x, int y) {
    const dirs = [[2, 0], [-2, 0], [0, 2], [0, -2]];
    return dirs
        .map((dir) => [x + dir[0], y + dir[1]])
        .where((pos) => _inBounds(pos[0], pos[1]) && !grid[pos[1]][pos[0]].isWall)
        .map((pos) => grid[pos[1]][pos[0]])
        .toList();
  }

  bool _inBounds(int x, int y) => x >= 0 && x < width && y >= 0 && y < height;
}
