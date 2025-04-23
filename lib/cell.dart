class Cell {
  final int x, y;
  bool isWall;
  bool isPath;
  bool isVisited;
  bool isCurrent;
  Cell? parent;

  Cell({
    required this.x,
    required this.y,
    this.isWall = true,
    this.isPath = false,
    this.isVisited = false,
    this.isCurrent = false,
    this.parent,
  });
}
