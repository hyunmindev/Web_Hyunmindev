import 'package:flutter/material.dart';

class GameCustomPaint extends StatefulWidget {
  _GameCustomPaintState createState() => _GameCustomPaintState();
}

class _GameCustomPaintState extends State<GameCustomPaint> {
  Offset _position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) {
        setState(() {
          _position = event.position;
        });
      },
      child: CustomPaint(
        painter: MyPainter(
          color: Theme.of(context).highlightColor,
          position: _position,
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Color color;
  final Offset position;

  MyPainter({required this.color, required this.position});

  void drawLine(canvas, size, y) {
    Paint paint = Paint();
    paint.color = color;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 8.0;
    Offset p1 = Offset(0, y);
    Offset p2 = Offset(size.width, y);
    canvas.drawLine(p1, p2, paint);
  }

  void drawBar(canvas, size, x) {
    Paint paint = Paint();
    paint.color = color;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 8.0;
    Offset p1 = Offset(x - 100, size.height * 4 / 5);
    Offset p2 = Offset(x + 100, size.height * 4 / 5);
    canvas.drawLine(p1, p2, paint);
  }

  void drawCircle(canvas, size, x, y, radius) {
    Paint paint = Paint();
    paint.color = color;
    paint.strokeCap = StrokeCap.round;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 8.0;
    Offset center = Offset(x, y);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawLine(canvas, size, 0);
    drawLine(canvas, size, size.height);
    drawCircle(canvas, size, position.dx, position.dy, 24);
    drawBar(canvas, size, position.dx);
    print(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
