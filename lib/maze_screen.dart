import 'dart:async';
import 'package:flutter/material.dart';
import 'package:escape_maze/maze_generator.dart';
import 'maze_painter.dart';

class MazeScreen extends StatefulWidget {
  const MazeScreen({super.key});

  @override
  State<MazeScreen> createState() => _MazeScreenState();
}

class _MazeScreenState extends State<MazeScreen> {
  MazeGenerator? maze;
  Timer? _timer;

  final _widthController = TextEditingController(text: '41');
  final _heightController = TextEditingController(text: '41');

  int width = 41;
  int height = 41;

  bool generationComplete = false;

  void startAnimation() {
    _timer?.cancel();

    int? w = int.tryParse(_widthController.text);
    int? h = int.tryParse(_heightController.text);

    if (w == null || h == null || w < 5 || h < 5 || w % 2 == 0 || h % 2 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter odd numbers ≥ 5 for width and height.'),
        ),
      );
      return;
    }

    setState(() {
      width = w;
      height = h;
      maze = MazeGenerator(width, height);
      maze!.initialize();
      generationComplete = false; // Reset before starting
    });

    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      bool hasNext = maze!.step();
      setState(() {});
      if (!hasNext) {
        timer.cancel();
        setState(() {
          generationComplete = true; // Set when done
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Prim's Maze Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _widthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Width (odd)',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Height (odd)',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white)
                  ),
                    onPressed: startAnimation, child: Text("Start")),
              ],
            ),
            SizedBox(height: 10),

            // Maze rendering
            if (maze != null)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: CustomPaint(
                      painter: MazePainter(maze!),
                      size: Size(width * 10.0, height * 10.0),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Text(
                    "Enter dimensions and press Start",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

            if (generationComplete)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 100),
                child: Text(
                  "Time Complexity of Prim's Algorithm: O(E log V)",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
