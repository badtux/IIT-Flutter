import 'package:flutter/material.dart';

class CustomProgressIndicatorButton extends StatefulWidget {
  @override
  _CustomProgressIndicatorButtonState createState() =>
      _CustomProgressIndicatorButtonState();
}

class _CustomProgressIndicatorButtonState
    extends State<CustomProgressIndicatorButton> {
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
    return ElevatedButton(
      onPressed: progress >= 1.0 ? null : _increaseProgress,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(300, 100), // Adjust the size as needed
        padding: EdgeInsets.all(0), // Remove padding for better fit
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Increase Progress',
            style: TextStyle(color: Color.fromARGB(255, 19, 9, 9)),
          ),
          SizedBox(width: 50),
          CustomPaint(
            size: Size(30, 30), // Adjust the size as needed
            painter: _ProgressPainter(progress),
          ),
        ],
      ),
      // child: Stack(
      //   alignment: Alignment.center,
      //   children: [
      //     CustomPaint(
      //       size: Size(100, 100),
      //       painter: _ProgressPainter(progress),
      //     ),
      //     Text(
      //       'Increase\nProgress',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(color: Color.fromARGB(255, 32, 21, 21)fromARGB(255, 56, 56, 56)),
      //     ),
      //   ],
      // ),
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
        appBar: AppBar(title: Text('Custom Progress Indicator Button')),
        body: Center(child: CustomProgressIndicatorButton()),
      ),
    );
  }
}
