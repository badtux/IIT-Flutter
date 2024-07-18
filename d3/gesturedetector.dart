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

  void _showAvatarInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Avatar Info'),
          content: Text('This is the profile picture of the user.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: progress >= 1.0 ? null : _increaseProgress,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _showAvatarInfo,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1401543761117605906/iixijDjd_400x400.jpg'),
              radius: 35, // Adjust the radius to make the avatar bigger
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Increase Progress',
            style: TextStyle(color: Color.fromARGB(255, 94, 3, 78)),
          ),
          SizedBox(width: 10),
          CustomPaint(
            size: Size(30, 30), // Adjust the size as needed
            painter: _ProgressPainter(progress),
          ),
        ],
      ),
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
      ..strokeWidth = 4;

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
