import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Custom Fonts Example')),
        body: Center(
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(
              fontFamily: 'MyCustomFont', // Use the font family name defined in pubspec.yaml
              fontWeight: FontWeight.bold, // Optional: Specify font weight
              fontStyle: FontStyle.italic, // Optional: Specify font style
              fontSize: 24,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}