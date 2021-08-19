import 'package:flutter/material.dart';

class GameCustomPaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Sky(),
    );
  }
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint(); // Paint 클래스는 어떤 식으로 화면을 그릴지 정할 때 쓰임.
    paint.color = Color(0xffE7D2CC); // 색은 보라색
    paint.strokeCap = StrokeCap.round; // 선의 끝은 둥글게 함.
    paint.strokeWidth = 14.0; // 선의 굵기는 4.0
    Offset p1 = Offset(0.0, 0.0); // 선을 그리기 위한 좌표값을 만듬.
    Offset p2 = Offset(size.width, size.height);
    canvas.drawLine(p1, p2, paint); // 선을 그림.
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
