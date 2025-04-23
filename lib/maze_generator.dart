import 'dart:math';

class PrimMaze {
  final int width;
  final int height;
  late List<List<bool>> grid;
  Set<Point<int>> _frontiers = {};
  Point<int>? currentFrontier;

  PrimMaze(this.width, this.height) {
    grid = List.generate(width, (_) => List.generate(height, (_) => false));
    _init();
  }

  void _init() {
    final rand = Random();
    int x = rand.nextInt(width ~/ 2) * 2 + 1;
    int y = rand.nextInt(height ~/ 2) * 2 + 1;
    grid[x][y] = true;
    _frontiers = _getFrontiers(x, y);
  }

  Set<Point<int>> _getFrontiers(int x, int y) {
    final frontiers = <Point<int>>{};
    for (var offset in [Point(-2, 0), Point(2, 0), Point(0, -2), Point(0, 2)]) {
      int nx = x + offset.x;
      int ny = y + offset.y;
      if (_inBounds(nx, ny) && !grid[nx][ny]) {
        frontiers.add(Point(nx, ny));
      }
    }
    return frontiers;
  }

  bool _inBounds(int x, int y) =>
      x > 0 && y > 0 && x < width - 1 && y < height - 1;

  bool step() {
    if (_frontiers.isEmpty) return false;

    final rand = Random();
    currentFrontier = _frontiers.elementAt(rand.nextInt(_frontiers.length));
    _frontiers.remove(currentFrontier);

    int x = currentFrontier!.x;
    int y = currentFrontier!.y;

    List<Point<int>> neighbors = [];
    for (var offset in [Point(-2, 0), Point(2, 0), Point(0, -2), Point(0, 2)]) {
      int nx = x + offset.x;
      int ny = y + offset.y;
      if (_inBounds(nx, ny) && grid[nx][ny]) {
        neighbors.add(Point(nx, ny));
      }
    }

    if (neighbors.isNotEmpty) {
      final chosen = neighbors[rand.nextInt(neighbors.length)];
      int wallX = (x + chosen.x) ~/ 2;
      int wallY = (y + chosen.y) ~/ 2;
      grid[x][y] = true;
      grid[wallX][wallY] = true;

      _frontiers.addAll(_getFrontiers(x, y));
    }

    return true;
  }
}
