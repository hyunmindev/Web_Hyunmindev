import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  Offset _circleDeltaPosition = Offset(3, 3);
  Offset _circlePosition = Offset(0, 0);
  Offset _offset = Offset(0, 0);
  double _circleSize = 24;
  Size _size = Size(0, 0);
  bool _isFirstBuild = true;
  bool _isBouncing = false;
  int _bounceCount = 0;
  double _barRadian = 0;
  Offset _barP1 = Offset(0, 0);
  Offset _barP2 = Offset(0, 0);

  double getDistance(p1, p2, p) {
    return ((p2.dx - p1.dx) * (p1.dy - p.dy) - (p1.dx - p.dx) * (p2.dy - p1.dy))
            .abs() /
        sqrt(pow(p2.dx - p1.dx, 2) + pow((p2.dy - p1.dy), 2));
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _circlePosition += _circleDeltaPosition;
      });
      if (_circlePosition.dy < 0 + _circleSize) {
        _circleDeltaPosition =
            Offset(_circleDeltaPosition.dx, log(_bounceCount + 8) * 2);
      }
      if (_circlePosition.dy > _size.height - _circleSize) {
        _circleDeltaPosition =
            Offset(_circleDeltaPosition.dx, -log(_bounceCount + 8) * 2);
      }
      if (_circlePosition.dx < 0 + _circleSize) {
        _circleDeltaPosition =
            Offset(log(_bounceCount + 8) * 2, _circleDeltaPosition.dy);
      }
      if (_circlePosition.dx > _size.width - _circleSize) {
        _circleDeltaPosition =
            Offset(-log(_bounceCount + 8) * 2, _circleDeltaPosition.dy);
      }
      if (_circlePosition.dx + _circleSize > _barP1.dx &&
          _circlePosition.dx - _circleSize < _barP2.dx &&
          getDistance(_barP1, _barP2, _circlePosition) < _circleSize) {
        if (!_isBouncing) {
          _bounceCount += 1;
          _circleDeltaPosition = Offset(
              -_circleDeltaPosition.dx * -1, _circleDeltaPosition.dy * -1);
        }
        _isBouncing = true;
      } else {
        _isBouncing = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      RenderBox box = globalKey.currentContext!.findRenderObject() as RenderBox;
      if (_isFirstBuild) {
        _offset = box.localToGlobal(Offset.zero);
        _isFirstBuild = false;
        _circlePosition = Offset(box.size.width / 2, box.size.height / 2 + 50);
        _barP1 = Offset(box.size.width / 2 - 100, box.size.height / 2 + 90);
        _barP2 = Offset(box.size.width / 2 + 100, box.size.height / 2 + 90);
      }
      _size = box.size;
    });
    return Listener(
      key: globalKey,
      onPointerHover: (event) {
        setState(() {
          Offset position = event.position - _offset;
          Offset center = Offset(_size.width / 2, _size.height / 2);
          _barRadian = ((position.dx - center.dx) / center.dx) * pi / 2;
          _barP1 = Offset(position.dx - cos(_barRadian) * 100,
              position.dy + sin(_barRadian) * 100);
          _barP2 = Offset(position.dx + cos(_barRadian) * 100,
              position.dy - sin(_barRadian) * 100);
        });
      },
      child: CustomPaint(
        painter: MyPainter(
          color: Theme.of(context).highlightColor,
          circlePosition: _circlePosition,
          circleSize: _circleSize,
          barP1: _barP1,
          barP2: _barP2,
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Color color;
  final Offset circlePosition;
  final double circleSize;
  final Offset barP1;
  final Offset barP2;

  MyPainter(
      {required this.color,
      required this.circlePosition,
      required this.circleSize,
      required this.barP1,
      required this.barP2});

  void drawLine(canvas, size, dy) {
    Paint paint = Paint();
    paint.color = color;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 8.0;
    Offset p1 = Offset(0, dy);
    Offset p2 = Offset(size.width, dy);
    canvas.drawLine(p1, p2, paint);
  }

  void drawBar(canvas, size, p1, p2) {
    Paint paint = Paint();
    paint.color = color;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 8.0;
    canvas.drawLine(p1, p2, paint);
  }

  void drawCircle(canvas, size, x, y) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    Offset center = Offset(x, y);
    canvas.drawCircle(center, circleSize, paint);
  }

  void drawText(canvas, size, text) {
    TextSpan textSpan = TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'Dosis',
        fontSize: 32,
      ),
    );
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    double xCenter = (size.width - textPainter.width) / 2;
    double yCenter = (size.height - textPainter.height) / 2;
    Offset offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawLine(canvas, size, 0);
    drawLine(canvas, size, size.height);
    drawCircle(canvas, size, circlePosition.dx, circlePosition.dy);
    drawBar(canvas, size, barP1, barP2);
    drawText(canvas, size, "I am developer");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
