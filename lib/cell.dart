class Cell {
  final int x, y;
  bool isWall;
  bool isCurrent;

  Cell({required this.x, required this.y, this.isWall = true, this.isCurrent = false});
}
