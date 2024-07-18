import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Fonts Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Hello, Flutter!',
                style: GoogleFonts.comicNeue(
                  textStyle: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Center(
              child: Text(
                'Console Text',
                style: GoogleFonts.robotoMono(
                  textStyle: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

