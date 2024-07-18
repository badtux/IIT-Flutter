import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _openYouTubePlaylist() async {
    final uri = Uri.parse(
        'https://www.youtube.com/playlist?list=PLWHBGg0vTsI19PIAg4XIT8TvdBW7CfXpd');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void _showAvatarInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kat Jade'),
          content: Text(
              'Kat Jade is a vocalist associated with the Hindley Street Country Club (HSCC), a music group known for its high-quality covers of popular songs.'),
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
            onDoubleTap: _openYouTubePlaylist,
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
