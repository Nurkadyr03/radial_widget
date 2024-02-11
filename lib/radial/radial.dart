// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:flutter/material.dart';

class RadialWidget extends StatefulWidget {
  const RadialWidget({Key? key}) : super(key: key);

  @override
  State<RadialWidget> createState() => _RadialWidgetState();
}

class _RadialWidgetState extends State<RadialWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
        
          child: RadialPercentWidget(
            percent: 0.72,
            fillColor: Colors.blue,
            lineColor: Colors.red,
            freeColor: Colors.yellow,
            lineWidth: 5,
            child: Text(
              "72%",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialPercentWidget extends StatelessWidget {
  final Widget child;
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;
  const RadialPercentWidget({
    Key? key,
    required this.child,
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.freeColor,
    required this.lineWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
            percent: percent,
            fillColor: fillColor,
            lineColor: lineColor,
            freeColor: freeColor,
            lineWidth: lineWidth,
            child: child,
          ),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Center(child: child),
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final Widget child;
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;
  MyPainter({
    required this.child,
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.freeColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
Rect arcRect = calculateArcsRect(size);
    drowBackground(canvas, size);
    // canvas.drawCircle(Offset(size.width/2,size.height/2),size.width/2, paint);
    drowFiledArc(canvas, arcRect);

    drowFillArc(canvas, arcRect);
  }

  void drowFillArc(Canvas canvas, Rect arcRect) {
     final fillPaint = Paint();
    fillPaint.color = lineColor;
    fillPaint.style = PaintingStyle.stroke;
    fillPaint.strokeCap = StrokeCap.round; //конечная дуга
    fillPaint.strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2 * percent,
      false,
      fillPaint,
    );
  }

  void drowFiledArc(Canvas canvas, Rect arcRect) {
    final filedPaint = Paint();
    filedPaint.color = freeColor;
    filedPaint.style = PaintingStyle.stroke;
    filedPaint.strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - 0.72),
      false,
      filedPaint,
    );
  }

  void drowBackground(Canvas canvas, Size size) {
     final backpainter = Paint();
    backpainter.color = fillColor;
    backpainter.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backpainter);
  }

  Rect calculateArcsRect(Size size) {
    const lineMargin=3;
        final offset=lineWidth/2+lineMargin;
        final arcRect =
             Offset(offset, offset) & Size(size.width - offset*2, size.height -  offset*2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
