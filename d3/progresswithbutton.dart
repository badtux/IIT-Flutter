import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  @override
  _CustomProgressIndicatorState createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  double progress = 0.0;

  void _increaseProgress() {
    setState(() {
      progress += 0.1;
      if (progress > 1.0) {
        progress = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPaint(
          size: Size(100, 100),
          painter: _ProgressPainter(progress),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: progress >= 1.0 ? null : _increaseProgress,
          child: Text('Increase Progress'),
        ),
      ],
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = progress >= 1.0 ? Colors.red : Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    double radius = size.width / 2;
    Rect rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    canvas.drawArc(rect, -1.57, progress * 6.28, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Custom Progress Indicator')),
        body: Center(child: CustomProgressIndicator()),
      ),
    );
  }
}
