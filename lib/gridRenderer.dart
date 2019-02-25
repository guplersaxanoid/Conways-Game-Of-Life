import 'package:flutter/material.dart';
import 'package:cellular_automata/cellular_automata.dart';


class GridPainter extends CustomPainter {
  const GridPainter({

    this.snapshot,
  });


  final CellGrid snapshot;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint();
    for (double y = 0.0; y <= size.height; y += 5.0) {
      linePaint.color = Color.fromRGBO(53, 50, 48, 1.0);
      for(double x = 0.0; x <= size.width; x+= 5.0){
        snapshot.get(x~/5, y~/5) == '*' ? linePaint.color = Color.fromRGBO(7, 243, 229, 1.0): linePaint.color = Color.fromRGBO(53, 50, 48, 1.0);
        linePaint.strokeWidth = 5.0;
        canvas.drawLine(Offset(x, y ), Offset(x, y+5.0), linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(GridPainter oldPainter) {
    return true;
  }

  @override
  bool hitTest(Offset position) => false;
}