import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  Offset _circleDeltaPosition = Offset(3, 3);
  Offset _pointerPosition = Offset(0, 0);
  Offset _circlePosition = Offset(0, 0);
  Offset _offset = Offset(0, 0);
  double _circleSize = 24;
  Size _size = Size(0, 0);
  bool _isFirstBuild = true;
  int _bounceCount = 0;
  bool _isBouncing = false;
  double _barAngle = 0;

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
      if (_circlePosition.dx + _circleSize > _pointerPosition.dx - 100 &&
          _circlePosition.dx - _circleSize < _pointerPosition.dx + 100 &&
          _circlePosition.dy + _circleSize > _pointerPosition.dy - 4 &&
          _circlePosition.dy - _circleSize < _pointerPosition.dy + 4) {
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
        _pointerPosition = Offset(box.size.width / 2, box.size.height / 2 + 90);
        _circlePosition = Offset(box.size.width / 2, box.size.height / 2 + 50);
      }
      _size = box.size;
    });
    return Listener(
      key: globalKey,
      onPointerHover: (event) {
        setState(() {
          _pointerPosition = event.position - _offset;
          Offset center = Offset(_size.width / 2, _size.height / 2);
          _barAngle = ((_pointerPosition.dx - center.dx) / center.dx) * 90;
        });
      },
      child: CustomPaint(
        painter: MyPainter(
          color: Theme.of(context).highlightColor,
          pointerPosition: _pointerPosition,
          circlePosition: _circlePosition,
          circleSize: _circleSize,
          barAngle: _barAngle,
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Color color;
  final Offset pointerPosition;
  final Offset circlePosition;
  final double circleSize;
  final double barAngle;

  MyPainter(
      {required this.color,
      required this.pointerPosition,
      required this.circlePosition,
      required this.circleSize,
      required this.barAngle});

  void drawLine(canvas, size, dy) {
    Paint paint = Paint();
    paint.color = color;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 8.0;
    Offset p1 = Offset(0, dy);
    Offset p2 = Offset(size.width, dy);
    canvas.drawLine(p1, p2, paint);
  }

  void drawBar(canvas, size, dx, dy, degree) {
    Paint paint = Paint();
    paint.color = color;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 8.0;
    double radian = degree * pi / 180;
    Offset p1 = Offset(dx - cos(radian) * 100, dy + sin(radian) * 100);
    Offset p2 = Offset(dx + cos(radian) * 100, dy - sin(radian) * 100);
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
    drawBar(canvas, size, pointerPosition.dx, pointerPosition.dy, barAngle);
    drawText(canvas, size, "I am developer");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
